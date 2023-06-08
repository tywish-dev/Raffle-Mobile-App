// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:raffle_mobile_app/data/models/user_auth.dart';
import '../providers/user_auth_provider.dart';
import '/ui/screens/login_screen.dart';
import '/ui/widgets/custom_button.dart';
import '/ui/widgets/custom_text_field.dart';
import '/data/constants/constants.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController nameController;
  late TextEditingController surnameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  @override
  void initState() {
    nameController = TextEditingController();
    surnameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserAuthProvider userAuthProvider = Provider.of<UserAuthProvider>(context);
    return GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dx > 25) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    width: MediaQuery.of(context).size.width * 0.2,
                  ),
                  Text(
                    "Kayıt Ol",
                    style: TextStyle(
                      color: mainBlack,
                      fontSize: 40,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.38,
                          child: CustomTextField(
                            hintText: "Ad",
                            isObsecure: false,
                            controller: nameController,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.38,
                          child: CustomTextField(
                            hintText: "Soyad",
                            isObsecure: false,
                            controller: surnameController,
                          ),
                        ),
                      ],
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
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: CustomTextField(
                      hintText: "Şifreyi Onayla",
                      isObsecure: true,
                      controller: confirmPasswordController,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.055,
                    child: CustomButton(
                      onPressed: () async {
                        if (passwordController.text !=
                            confirmPasswordController.text) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Center(
                                child: Text(
                                  'Şifreler uyuşmuyor',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24),
                                ),
                              ),
                            ),
                          );
                        } else if (passwordController.text == "" ||
                            confirmPasswordController.text == "" ||
                            emailController.text == "") {
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
                          userAuthProvider.user!.name = nameController.text;
                          userAuthProvider.user!.lastName =
                              surnameController.text;
                          userAuthProvider.user!.img = "";
                          await userAuthProvider.signUp(
                            UserAuth(
                                email: emailController.text,
                                password: passwordController.text,
                                returnSecureToken: true),
                            userAuthProvider.user!,
                          );
                          Navigator.pop(
                            context,
                            PageTransition(
                              child: const LoginScreen(),
                              type: PageTransitionType.fade,
                            ),
                          );
                        }
                      },
                      text: "Kayıt Ol",
                      bgColor: mainGreen,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
