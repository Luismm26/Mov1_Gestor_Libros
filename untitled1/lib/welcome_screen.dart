import 'package:flutter/material.dart';
import 'package:untitled1/login_screen.dart';
import 'package:untitled1/register_screen.dart';
import 'colors.dart';  // Importa el archivo donde definiste los colores

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorPrincipal1,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Text(
                'Bienvenido',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Material(

                color: Colors.transparent, // Color del botón
                child: InkWell(

                  onTap: () {
                    // Acción para el botón de login
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 38, vertical: 25),
                    child: Text(
                      'Iniciar Sesión',
                      style: TextStyle(fontSize: 18, color: Colors.blue),
                    ),
                  ),
                ),
              ),
              Material(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), // Redondea la esquina superior derecha
                ),
                color: Colors.blue, // Color del botón
                child: InkWell(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30), // Redondea la esquina superior izquierda
                  ),
                  onTap: () {
                    // Acción para el botón de registro
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 38, vertical: 25),
                    child: Text(
                      'Registrarse',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
