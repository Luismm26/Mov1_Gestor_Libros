const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const cors = require('cors');
const jwt = require('jsonwebtoken');
const multer = require('multer');
const path = require('path');

const app = express();
app.use(bodyParser.json());
app.use(cors());

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, 'uploads/');
  },
  filename: (req, file, cb) => {
    cb(null, file.originalname);
  }
});

const upload = multer({ storage: storage });

mongoose.connect('mongodb+srv://xadannyperez:LxC55jB9fOanCGbd@cluster0.uydub.mongodb.net/mydatabase?retryWrites=true&w=majority', {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  }).then(() => {
    console.log('Connected to MongoDB Atlas');
  }).catch((error) => {
    console.error('Error connecting to MongoDB Atlas', error);
  });

const UserSchema = new mongoose.Schema({
  username: String,
  email: String,
  password: String,
  profilePicture: String,
});

const User = mongoose.model('User', UserSchema);

app.post('/register', upload.single('profilePicture'), async (req, res) => {
  try {
    const { username, email, password } = req.body;
    const profilePicture = req.file ? req.file.path.replace(/\\/g, '/') : null;

    console.log('Request body:', req.body);

    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res.status(400).json({ error: 'User already exists' });
    }

    const user = new User({ username, email, password, profilePicture });
    await user.save();

    res.status(201).json({ message: 'User registered successfully' });
  } catch (error) {
    console.error('Error during registration:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

app.post('/login', async (req, res) => {
  try {
    const { email, password } = req.body;

    const user = await User.findOne({ email });

    if (!user || user.password !== password) {
      return res.status(400).json({ error: 'Correo o Contraseña incorrectos.' });
    }

    res.status(200).json({ username: user.username });
  } catch (error) {
    console.error('Error during login:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

app.get('/user/:username', async (req, res) => {
  try {
    const username = req.params.username;
    const user = await User.findOne({ username });

    if (!user) {
      return res.status(404).json({ error: 'Usuario no encontrado' });
    }

    const profilePicturePath = user.profilePicture ? user.profilePicture.replace(/\\/g, '/') : null;

    res.status(200).json({
      username: user.username,
      profilePicture: profilePicturePath,
    });
  } catch (error) {
    console.error('Error al obtener la información del usuario:', error);
    res.status(500).json({ error: 'Error Interno del Servidor' });
  }
});

app.use('/uploads', express.static('uploads'));

app.get('/', (req, res) => {
  res.send('Servidor funcionando correctamente');
});

const port = 3000;

app.listen(port, '192.168.0.104', () => {
  console.log(`Server running on http://192.168.0.104:${port}`);
});
