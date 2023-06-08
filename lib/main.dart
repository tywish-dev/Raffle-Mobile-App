import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/ui/providers/ticket_provider.dart';
import '/ui/providers/product_provider.dart';
import '/ui/providers/user_auth_provider.dart';
import '/app_init.dart';
import '/ui/providers/category_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ListenableProvider(create: (_) => CategoryProvider()),
        ListenableProvider(create: (_) => UserAuthProvider()),
        ListenableProvider(create: (_) => ProductProvider()),
        ListenableProvider(create: (_) => TicketProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Raffle Mobile App',
      theme: ThemeData(
        fontFamily: 'Manrope',
        scaffoldBackgroundColor: const Color(0xFFFFFFFF),
        primarySwatch: Colors.blue,
      ),
      home: const AppInit(),
    );
  }
}
