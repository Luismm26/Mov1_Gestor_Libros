import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:untitled1/welcome_screen.dart';
import 'colors.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  bool _isSearching = false;
  String _searchQuery = "";

  final List<Widget> _children = [
    InicioPage(),
    PublicarForm(),
    PerfilPage(), // Página de perfil
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchQuery = ""; // Clear the search query when closing search
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
          autofocus: true,
          onChanged: (query) {
            setState(() {
              _searchQuery = query;
            });
          },
          decoration: InputDecoration(
            hintText: 'Buscar libros...',
            hintStyle: TextStyle(color: AppColors.color2),
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search, color: AppColors.color2),
            filled: true,
            fillColor: AppColors.color3,
          ),
          style: TextStyle(color: AppColors.color2),
        )
            : Text(
          'StorySphere',
          style: TextStyle(color: AppColors.color2), // Color del título
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.logout, color: AppColors.color2), // Color del ícono
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WelcomeScreen()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search, color: AppColors.color2),
            onPressed: _toggleSearch,
          ),
        ],
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: AppColors.color2), // Color del ícono
            label: 'Inicio',
            backgroundColor: AppColors.color2, // Color de fondo
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add, color: AppColors.color2), // Color del ícono
            label: 'Publicar',
            backgroundColor: AppColors.color2, // Color de fondo
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: AppColors.color2), // Color del ícono
            label: 'Perfil',
            backgroundColor: AppColors.color2, // Color de fondo
          ),
        ],
        selectedItemColor: AppColors.color3, // Color del ítem seleccionado
        unselectedItemColor: AppColors.color2, // Color del ítem no seleccionado
        backgroundColor: AppColors.color1, // Color de fondo del BottomNavigationBar
      ),
    );
  }
}


class InicioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          _buildPublicacionCard(
            'Título del libro 1',
            'Autor 1',
            'Reseña del libro 1',
            'Nombre del Usuario 1',
            'assets/user1.jpg',
            4.5,
            'Ficción, Aventura',
            null,
            context,
          ),
          _buildPublicacionCard(
            'Título del libro 2',
            'Autor 2',
            'Reseña del libro 2',
            'Nombre del Usuario 2',
            'assets/user2.jpg',
            3.0,
            'Misterio, Suspense',
            null,
            context,
          ),
          // Añadir más tarjetas de publicaciones aquí
        ],
      ),
    );
  }

  Widget _buildPublicacionCard(
      String titulo,
      String autor,
      String resena,
      String nombreUsuario,
      String imagenUsuario,
      double calificacion,
      String categorias,
      File? imagen,
      BuildContext context,
      ) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      color: AppColors.color3, // Color del fondo de la tarjeta
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(imagenUsuario),
                  radius: 25,
                ),
                SizedBox(width: 10),
                Text(
                  nombreUsuario,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.color2, // Color del texto del nombre del usuario
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        titulo,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.color2, // Color del texto del título
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        autor,
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.color5, // Color del texto del autor
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        resena,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.color2, // Color del texto de la reseña
                        ),
                      ),
                    ],
                  ),
                ),
                if (imagen != null)
                  Container(
                    width: 100, // Ancho de la imagen
                    height: 150,
                    margin: EdgeInsets.only(left: 16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: FileImage(imagen),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                else
                  Container(
                    width: 100,
                    height: 150,
                    color: AppColors.color4, // Color de fondo si no hay imagen
                    margin: EdgeInsets.only(left: 16.0),
                    child: Center(
                      child: Text(
                        'Sin imagen',
                        style: TextStyle(
                          color: AppColors.color5, // Color del texto si no hay imagen
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'Categorías: $categorias',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.color5, // Color del texto de las categorías
              ),
            ),
            SizedBox(height: 8),
            RatingBarIndicator(
              rating: calificacion,
              itemBuilder: (context, index) => Icon(
                Icons.star,
                color: AppColors.color4, // Color de las estrellas
              ),
              itemCount: 5,
              itemSize: 24.0,
              direction: Axis.horizontal,
            ),
          ],
        ),
      ),
    );
  }
}


class PerfilPage extends StatefulWidget {
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  File? _profileImage;
  String _nombreUsuario = 'Nombre de Usuario';

  Future<void> _pickProfileImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: _pickProfileImage,
            child: CircleAvatar(
              radius: 60,
              backgroundImage:
              _profileImage != null ? FileImage(_profileImage!) : null,
              child: _profileImage == null
                  ? Icon(Icons.person, size: 60, color: AppColors.color5)
                  : null,
            ),
          ),
          SizedBox(height: 16),
          Text(
            _nombreUsuario,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.color2, // Color del nombre de usuario
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: [
                _buildPublicacionCard(
                  'Título del libro 1',
                  'Autor 1',
                  'Reseña del libro 1',
                  4.5,
                  'Ficción, Aventura',
                  null, // Imagen opcional
                  context,
                ),
                _buildPublicacionCard(
                  'Título del libro 2',
                  'Autor 2',
                  'Reseña del libro 2',
                  3.0,
                  'Misterio, Suspense',
                  null, // Imagen opcional
                  context,
                ),
                // Puedes añadir más tarjetas de publicaciones aquí
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPublicacionCard(
      String titulo,
      String autor,
      String resena,
      double calificacion,
      String categorias,
      File? imagen,
      BuildContext context,
      ) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      color: AppColors.color3, // Color de fondo de la tarjeta
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        titulo,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.color2, // Color del título
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        autor,
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.color5, // Color del autor
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        resena,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.color2, // Color de la reseña
                        ),
                      ),
                    ],
                  ),
                ),
                if (imagen != null)
                  Container(
                    width: 100,
                    height: 150,
                    margin: EdgeInsets.only(left: 16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: FileImage(imagen),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                else
                  Container(
                    width: 100,
                    height: 150,
                    color: AppColors.color4, // Color de fondo si no hay imagen
                    margin: EdgeInsets.only(left: 16.0),
                    child: Center(
                      child: Text(
                        'Sin imagen',
                        style: TextStyle(
                          color: AppColors.color5, // Color del texto si no hay imagen
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'Categorías: $categorias',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.color5, // Color de las categorías
              ),
            ),
            SizedBox(height: 8),
            RatingBarIndicator(
              rating: calificacion,
              itemBuilder: (context, index) => Icon(
                Icons.star,
                color: AppColors.color4, // Color de las estrellas
              ),
              itemCount: 5,
              itemSize: 24.0,
              direction: Axis.horizontal,
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: AppColors.color2),
                  onPressed: () {
                    _editPublicacion(
                      titulo,
                      autor,
                      resena,
                      calificacion,
                      categorias,
                      imagen,
                      context,
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: AppColors.color5),
                  onPressed: () {
                    _deletePublicacion(titulo, context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _editPublicacion(
      String titulo,
      String autor,
      String resena,
      double calificacion,
      String categorias,
      File? imagen,
      BuildContext context,
      ) {
    final _tituloController = TextEditingController(text: titulo);
    final _autorController = TextEditingController(text: autor);
    final _resenaController = TextEditingController(text: resena);
    final _categoriasController = TextEditingController(text: categorias);
    double _calificacion = calificacion;
    File? _imagen = imagen;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Editar publicación'),
          content: SingleChildScrollView(
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _tituloController,
                    decoration: InputDecoration(
                      labelText: 'Título del libro',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.color2),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _autorController,
                    decoration: InputDecoration(
                      labelText: 'Autor',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.color2),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _resenaController,
                    decoration: InputDecoration(
                      labelText: 'Reseña',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.color2),
                      ),
                    ),
                    maxLines: 3,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _categoriasController,
                    decoration: InputDecoration(
                      labelText: 'Categorías',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.color2),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text('Calificación'),
                  RatingBar.builder(
                    initialRating: _calificacion,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: AppColors.color4, // Color de las estrellas
                    ),
                    onRatingUpdate: (rating) {
                      _calificacion = rating;
                    },
                  ),
                  SizedBox(height: 16),
                  if (_imagen != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Image.file(
                        _imagen!,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Actualiza la publicación con los nuevos datos
                Navigator.of(context).pop();
              },
              child: Text('Guardar', style: TextStyle(color: AppColors.color2)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar', style: TextStyle(color: AppColors.color5)),
            ),
          ],
        );
      },
    );
  }

  void _deletePublicacion(String titulo, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Eliminar publicación'),
          content: Text('¿Estás seguro de que deseas eliminar $titulo?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar', style: TextStyle(color: AppColors.color5)),
            ),
            TextButton(
              onPressed: () {
                // Lógica para eliminar la publicación
                Navigator.of(context).pop();
              },
              child: Text('Eliminar', style: TextStyle(color: AppColors.color5)),
            ),
          ],
        );
      },
    );
  }
}

class PublicarForm extends StatefulWidget {
  @override
  _PublicarFormState createState() => _PublicarFormState();
}

class _PublicarFormState extends State<PublicarForm> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _autorController = TextEditingController();
  final _resenaController = TextEditingController();
  final _categoriasController = TextEditingController();

  double _calificacion = 0.0;
  File? _image;

  @override
  void dispose() {
    _tituloController.dispose();
    _autorController.dispose();
    _resenaController.dispose();
    _categoriasController.dispose();
    super.dispose();
  }

  Future<void> _openCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  void _publicar() {
    if (_formKey.currentState!.validate()) {
      final titulo = _tituloController.text;
      final autor = _autorController.text;
      final resena = _resenaController.text;
      final categorias = _categoriasController.text;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Publicación realizada con éxito'),
          backgroundColor: AppColors.color4, // Color del fondo del Snackbar
        ),
      );

      _tituloController.clear();
      _autorController.clear();
      _resenaController.clear();
      _categoriasController.clear();
      setState(() {
        _calificacion = 0.0;
        _image = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _tituloController,
                  decoration: InputDecoration(
                    labelText: 'Título del libro',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.color2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.color2),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el título del libro';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _autorController,
                  decoration: InputDecoration(
                    labelText: 'Autor',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.color2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.color2),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el autor del libro';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _resenaController,
                  decoration: InputDecoration(
                    labelText: 'Reseña',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.color2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.color2),
                    ),
                  ),
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese una reseña';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _categoriasController,
                  decoration: InputDecoration(
                    labelText: 'Categorías',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.color2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.color2),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese las categorías';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                Text('Calificación'),
                RatingBar.builder(
                  initialRating: _calificacion,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: AppColors.color4, // Color de las estrellas
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      _calificacion = rating;
                    });
                  },
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _openCamera,
                  child: Text('Abrir cámara'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: AppColors.color2, // Color del texto en el botón
                  ),
                ),
                if (_image != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Image.file(
                      _image!,
                      height: 200,
                      width: 200,
                    ),
                  ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _publicar,
                  child: Text('Publicar'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: AppColors.color4, // Color del texto en el botón
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}
