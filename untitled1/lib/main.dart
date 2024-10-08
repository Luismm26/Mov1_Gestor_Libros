import 'package:flutter/material.dart';
import 'welcome_screen.dart'; // Importa la pantalla de bienvenida

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomeScreen(), // Establece WelcomeScreen como la pantalla inicial
      debugShowCheckedModeBanner: false, //deshabilitar el banner
    );
  }
}
