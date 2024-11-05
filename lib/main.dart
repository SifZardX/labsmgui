import 'package:flutter/material.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lab02/ProfilePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _controller;
  late TextEditingController _controller2;
  var imageSource = "images/question-mark.jpg";
  final EncryptedSharedPreferences _encryptedPrefs = EncryptedSharedPreferences();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller2 = TextEditingController();
    _loadCredentials();
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }

  void _loadCredentials() async {
    String? savedUsername = await _encryptedPrefs.getString('username');
    String? savedPassword = await _encryptedPrefs.getString('password');

    if (savedUsername != null && savedPassword != null) {
      setState(() {
        _controller.text = savedUsername;
        _controller2.text = savedPassword;
      });
      _showSnackbar('Previous login loaded');
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _showSaveDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Save Login Credentials?"),
          content: const Text("Do you want to save your username and password?"),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                _encryptedPrefs.clear();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Save"),
              onPressed: () {
                _saveCredentials();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _saveCredentials() async {
    String username = _controller.text;
    String password = _controller2.text;
    String testString = "";

    await _encryptedPrefs.setString('username', username);
    await _encryptedPrefs.setString('password', password);

    if (password == "QWERTY123") {
      setState(() {
        imageSource = "images/light-bulb.jpg";
      });
      _showSnackbar('Login successful! Navigating to Profile...');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(username: username),
        ),
      );
    } else {
      setState(() {
        imageSource = "images/stop-sign.jpg";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: "Login",
                border: OutlineInputBorder(),
                labelText: "Login",
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _controller2,
              decoration: const InputDecoration(
                hintText: "Password",
                border: OutlineInputBorder(),
                labelText: "Password",
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _showSaveDialog,
              child: const Text("Login"),
            ),
            Image.asset(
              imageSource,
              width: 300,
              height: 300,
            ),
          ],
        ),
      ),
    );
  }
}