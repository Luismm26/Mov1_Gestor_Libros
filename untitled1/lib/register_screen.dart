import 'package:flutter/material.dart';
import 'package:untitled1/welcome_screen.dart';
import 'colors.dart';  // Importa el archivo donde definiste los colores

class RegisterScreen extends StatelessWidget {
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
                    AppColors.color5, // Color inicial del gradiente

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
                      'Registrarte',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.color5, // Color del texto del título
                      ),
                    ),
                    SizedBox(height: 50),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Usuario',
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
                    SizedBox(height: 50),
                    ElevatedButton(
                      onPressed: () {
                        // Acción para el botón de registro
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.color4, // Color del botón
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        'Registrarse',
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
    home: RegisterScreen(),
  ));
}
