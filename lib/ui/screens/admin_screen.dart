// ignore_for_file: avoid_unnecessary_containers

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '/ui/screens/login_screen.dart';
import '/data/models/product_model.dart';
import '/ui/providers/product_provider.dart';
import '/ui/widgets/custom_button.dart';
import '/ui/providers/category_provider.dart';
import '/ui/widgets/custom_dropdown_button.dart';
import '/data/constants/constants.dart';
import 'package:path/path.dart';

List<String> items = [
  "Koleksiyon",
  "Ev Eşyaları",
  "Teknoloji",
  "Taşıtlar",
  "İkinci El",
];

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  late TextEditingController productName;
  late TextEditingController productDesc;
  late TextEditingController productQty;
  late TextEditingController productPrice;

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
  }

  Future uploadFile() async {
    if (_photo == null) return;
    final fileName = basename(_photo!.path);
    final destination = 'files/$fileName';

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
  void initState() {
    productName = TextEditingController();
    productDesc = TextEditingController();
    productQty = TextEditingController();
    productPrice = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context);
    return GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dx > 25) {
          Navigator.push(
            context,
            PageTransition(
              child: const LoginScreen(),
              type: PageTransitionType.fade,
            ),
          );
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: Text(
            "Ürün Ekle",
            style: TextStyle(
              fontSize: 40,
              color: mainBlack,
            ),
          ),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              GestureDetector(
                onTap: () {
                  _showPicker(context);
                },
                child: _photo != null
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Image.file(
                          _photo!,
                          fit: BoxFit.contain,
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.grey[800],
                        ),
                      ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomDropdownButton2(
                    buttonHeight: MediaQuery.of(context).size.height * 0.065,
                    hint: "Kategori Seçin",
                    dropdownItems: items,
                    value: categoryProvider.getValue,
                    onChanged: (value) {
                      categoryProvider.setValue(value!);
                    },
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.08,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: TextField(
                      controller: productQty,
                      cursorColor: mainGray,
                      decoration: InputDecoration(
                        hintText: "Bilet Adet",
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(width: 1, color: mainGray),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(width: 1, color: mainGray),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextField(
                  controller: productName,
                  cursorColor: mainGray,
                  decoration: InputDecoration(
                    hintText: "Ürün Adı",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(width: 1, color: mainGray),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(width: 1, color: mainGray),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextField(
                  controller: productDesc,
                  cursorColor: mainGray,
                  keyboardType: TextInputType.multiline,
                  maxLines: 6,
                  decoration: InputDecoration(
                    hintText: "Ürün Açıklaması",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(width: 1, color: mainGray),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(width: 1, color: mainGray),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: TextField(
                      controller: productPrice,
                      cursorColor: mainGray,
                      decoration: InputDecoration(
                        hintText: "Bilet Fiyatı",
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(width: 1, color: mainGray),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(width: 1, color: mainGray),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.12,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.065,
                    child: CustomButton(
                      text: "Ürün Ekle",
                      bgColor: mainBlack,
                      onPressed: () async {
                        await uploadFile();
                        await productProvider.addProduct(
                          Product(
                            img: imgUrl!,
                            name: productName.text,
                            desc: productDesc.text,
                            price: productPrice.text,
                            category: categoryProvider
                                .undoCategoryName(categoryProvider.getValue),
                            quantity: productQty.text,
                            isFavorite: false,
                          ),
                          categoryProvider
                              .undoCategoryName(categoryProvider.getValue),
                        );

                        productName.text = "";
                        productDesc.text = "";
                        productPrice.text = "";
                        productQty.text = "";
                      },
                    ),
                  )
                ],
              ),
            ],
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
          child: Container(
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
          ),
        );
      },
    );
  }
}
