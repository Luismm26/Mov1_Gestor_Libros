import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'home_screen.dart';
import 'welcome_screen.dart';
import 'package:local_auth/local_auth.dart';
import 'colors.dart';  // Importa el archivo donde definiste los colores



class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    final String email = emailController.text;
    final String password = passwordController.text;

    try {
      final response = await http.post(
        Uri.parse('http://192.168.0.104:3000/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('username', responseBody['username']);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        final errorMessage = responseBody['error'] ?? 'Correo o Contraseña incorrectos.';
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text(errorMessage),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK', style: TextStyle(color: AppColors.color5)),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      print('Error: $e');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('No se pudo conectar con el servidor.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK', style: TextStyle(color: AppColors.color5)),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.color1,
      appBar: AppBar(
        title: Text('Regresar',
            style: TextStyle(
              color: AppColors.color2, // Color del texto del título
            )),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.color2),
          onPressed: () {
            // Acción para regresar
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WelcomeScreen()),
            );
          },
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.color5, // Color final del gradiente
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: AppColors.color3,  // Color de fondo del formulario
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Bienvenido de Regreso',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.color5, // Color del texto del título
                      ),
                    ),
                    SizedBox(height: 50),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(color: AppColors.color5), // Color del texto del label
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide(
                            color: AppColors.color5, // Color del borde al enfocar
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 25),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: AppColors.color5), // Color del texto del label
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide(
                            color: AppColors.color5, // Color del borde al enfocar
                          ),
                        ),
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Olvidé mi contraseña',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.color5,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 60),
                    ElevatedButton(
                      onPressed: () {
                        _login(context); // Llama a la función _login
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.color4, // Color del botón
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        'Iniciar Sesión',
                        style: TextStyle(color: AppColors.color5), // Color del texto del botón
                      ),
                    ),
                    SizedBox(height: 70),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LoginScreen(),
  ));
}
