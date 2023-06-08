// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '/ui/screens/winner_tickets.dart';
import '/ui/providers/user_auth_provider.dart';
import '/ui/screens/active_tickets.dart';
import '/ui/screens/favorites_screen.dart';
import '/ui/screens/login_screen.dart';
import '/ui/widgets/custom_label.dart';
import '/data/constants/constants.dart';
import 'package:path/path.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? imgUrl;

  FirebaseStorage storage = FirebaseStorage.instance;

  File? _photo;
  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
      } else {
        print('Resim seçilmedi.');
      }
    });

    await uploadFile();
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
      } else {
        print('Resim seçilmedi.');
      }
    });

    await uploadFile();
  }

  Future uploadFile() async {
    if (_photo == null) return;
    final fileName = basename(_photo!.path);
    final destination = 'profiles/$fileName';

    try {
      final ref = FirebaseStorage.instance.ref(destination).child('file/');
      await ref.putFile(_photo!);
      imgUrl = await ref.getDownloadURL();
      _photo = null;
    } catch (e) {
      print('Bir hata oluştu! \n$e');
    }
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
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05,
                    right: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          _showPicker(context);
                          userAuthProvider.user!.img = imgUrl;
                          await userAuthProvider.updateUserById(
                            userAuthProvider.user!.localId!,
                            userAuthProvider.user!,
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            userAuthProvider.user!.img == "" ||
                                    userAuthProvider.user!.img == null
                                ? "https://www.pngarts.com/files/10/Default-Profile-Picture-PNG-Download-Image.png"
                                : userAuthProvider.user!.img!,
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: MediaQuery.of(context).size.width * 0.4,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.02,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.48,
                        height: MediaQuery.of(context).size.width * 0.25,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "${userAuthProvider.user!.name} ${userAuthProvider.user!.lastName}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: mainBlack,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Aktif Biletlerim",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: mainBlack,
                                      ),
                                    ),
                                    Text(
                                      "${userAuthProvider.getActiveTickets.length} Adet",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: mainBlack,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                CustomLabel(
                  label: "Aktif Biletlerim",
                  onTap: () async {
                    await userAuthProvider.getATickets();
                    Navigator.push(
                      context,
                      PageTransition(
                        child: const ActiveTicketsScreen(),
                        type: PageTransitionType.fade,
                      ),
                    );
                  },
                  icon: BootstrapIcons.ticket_perforated_fill,
                  isTicket: true,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                CustomLabel(
                  label: "Kazandığım Biletlerim",
                  onTap: () async {
                    await userAuthProvider
                        .getWinnerTicketsF(userAuthProvider.user!.localId!);
                    Navigator.push(
                      context,
                      PageTransition(
                        child: const WinnerTicketsScreen(),
                        type: PageTransitionType.fade,
                      ),
                    );
                  },
                  icon: BootstrapIcons.ticket_perforated,
                  isTicket: true,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                CustomLabel(
                  label: "Favorilerim",
                  onTap: () async {
                    await userAuthProvider
                        .getFavoritesF(userAuthProvider.user!.localId!);
                    Navigator.push(
                      context,
                      PageTransition(
                        child: const FavoritesScreen(),
                        type: PageTransitionType.fade,
                      ),
                    );
                  },
                  icon: BootstrapIcons.heart_fill,
                  isTicket: false,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                CustomLabel(
                  label: "Çıkış Yap",
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                        child: const LoginScreen(),
                        type: PageTransitionType.fade,
                      ),
                    );
                  },
                  icon: BootstrapIcons.box_arrow_right,
                  isTicket: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Galeri'),
                  onTap: () {
                    imgFromGallery();

                    Navigator.of(context).pop();
                  }),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Kamera'),
                onTap: () {
                  imgFromCamera();

                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
