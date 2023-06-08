// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:raffle_mobile_app/ui/providers/product_provider.dart';
import '/ui/screens/admin_screen.dart';
import '/data/models/user_auth.dart';
import '/data/services/user_services.dart';
import '/ui/providers/user_auth_provider.dart';
import '/ui/screens/home_screen.dart';
import '/ui/screens/sign_up_screen.dart';
import '/ui/widgets/custom_button.dart';
import '/ui/widgets/custom_text_field.dart';
import '/data/constants/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController(text: "samet@test.com");
    passwordController = TextEditingController(text: "123456");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserAuthProvider userAuthProvider = Provider.of<UserAuthProvider>(context);
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  width: MediaQuery.of(context).size.width * 0.2,
                ),
                Text(
                  "Giriş Yap",
                  style: TextStyle(
                    color: mainBlack,
                    fontSize: 40,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: CustomTextField(
                    hintText: "E-Mail",
                    isObsecure: false,
                    controller: emailController,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: CustomTextField(
                    hintText: "Şifre",
                    isObsecure: true,
                    controller: passwordController,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.055,
                      child: CustomButton(
                        onPressed: () async {
                          if (emailController.text == "admin" &&
                              passwordController.text == "admin") {
                            Navigator.pushReplacement(
                              context,
                              PageTransition(
                                child: const AdminScreen(),
                                type: PageTransitionType.fade,
                              ),
                            );
                          } else {
                            if (emailController.text == "" ||
                                passwordController.text == "") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Center(
                                    child: Text(
                                      'Alanları kontrol edin',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              await userAuthProvider.signInBoolean(
                                  UserAuth(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      returnSecureToken: true),
                                  userAuthProvider.user!);
                              if (userAuthProvider.result == true) {
                                await userAuthProvider.getActiveTicketsF(
                                    userAuthProvider.user!.localId!);
                                await productProvider
                                    .getAllProducts("vehicles");
                                Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                    child: const HomeScreen(),
                                    type: PageTransitionType.fade,
                                  ),
                                );
                                userAuthProvider.user =
                                    await UserServices().getUserByLocalId(
                                  userAuthProvider.user!.localId!,
                                  userAuthProvider.user!.id,
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Center(
                                      child: Text(
                                        'Yanlış email veya şifre',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            }
                          }
                        },
                        text: "Giriş Yap",
                        bgColor: mainGreen,
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.055,
                      child: CustomButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              child: const SignUpScreen(),
                              type: PageTransitionType.fade,
                            ),
                          );
                        },
                        text: "Kayıt Ol",
                        bgColor: mainGray,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
