import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'colors.dart';
import 'home_screen.dart';
import 'welcome_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  File? _profileImage;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _profileImage = File(pickedImage.path);
      });
    }
  }

  Future<void> _register() async {
    final String username = _usernameController.text;
    final String email = _emailController.text;
    final String password = _passwordController.text;

    final uri = Uri.parse('http://192.168.0.104:3000/register');
    final request = http.MultipartRequest('POST', uri);

    request.fields['username'] = username;
    request.fields['email'] = email;
    request.fields['password'] = password;

    if (_profileImage != null) {
      request.files.add(await http.MultipartFile.fromPath('profilePicture', _profileImage!.path));
    }

    try {
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 201) {
        final responseJson = jsonDecode(responseBody);

        // Registro exitoso
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('username', username);


        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()), // Navegar a HomePage
        );
      } else {
        final responseJson = jsonDecode(responseBody);
        final errorMessage = responseJson['error'] ?? 'Error desconocido';
        _showErrorDialog(errorMessage);
      }
    } catch (e) {
      _showErrorDialog('No se pudo conectar con el servidor.');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
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
                  color: AppColors.color3, // Color de fondo del formulario
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
                    GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: _profileImage != null
                            ? FileImage(_profileImage!)
                            : null,
                        child: _profileImage == null
                            ? Icon(Icons.person, size: 60)
                            : null,
                      ),
                    ),
                    SizedBox(height: 16),
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
                      controller: _usernameController,
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
                      controller: _emailController,
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
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 25),
                    TextField(
                      controller: _passwordController,
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
                      onPressed: _register,
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