import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Login Page'),
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
  // Variables for text fields and image source
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  var imageSource = "images/question-mark.png"; // Default image

  void _login() {
    // Capture the password typed in the password field
    String password = _passwordController.text;

    setState(() {
      // If the password is correct, set the image to the light bulb.
      if (password == "QWERTY123") {
        imageSource = "images/idea.png";
      } else {
        // If incorrect, set the image to the stop sign.
        imageSource = "images/stop.png";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Text field for login name (optional, based on requirements)
              TextField(
                controller: _loginController,
                decoration: const InputDecoration(labelText: 'Login Name'),
              ),
              const SizedBox(height: 20),

              // Text field for password with obscure text (for password security)
              TextField(
                controller: _passwordController,
                obscureText: true, // This hides the password text as it is typed
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              const SizedBox(height: 20),

              // Elevated button to trigger login action
              ElevatedButton(
                onPressed: _login,
                child: const Text('Login'),
              ),
              const SizedBox(height: 20),

              // Image that will change based on password input
              Image.asset(
                imageSource,
                width: 300,  // Set the width and height of the image to 300 x 300
                height: 300,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
