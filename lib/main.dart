import 'package:flutter/material.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';  // Import for EncryptedSharedPreferences

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
  // Variables for text fields
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // SharedPreferences or EncryptedSharedPreferences instance
  late EncryptedSharedPreferences encryptedPrefs;

  @override
  void initState() {
    super.initState();
    encryptedPrefs = EncryptedSharedPreferences(); // Initialize encrypted shared preferences
    _loadLoginData();
  }

  // Load saved login data from EncryptedSharedPreferences
  void _loadLoginData() async {
    String? savedLogin = await encryptedPrefs.getString('username');
    String? savedPassword = await encryptedPrefs.getString('password');

    if (savedLogin != null && savedPassword != null) {
      _loginController.text = savedLogin;
      _passwordController.text = savedPassword;

      // Show Snackbar
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Previous login credentials loaded!'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: _undoReset,
        ),
      ));
    }
  }

  // Undo function: Reset text fields but don't remove data from EncryptedSharedPreferences
  void _undoReset() {
    setState(() {
      _loginController.clear();
      _passwordController.clear();
    });
  }

  // Show an AlertDialog to confirm if user wants to save their login data
  void _showSaveDialog() async {
    bool saveData = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Save Login Credentials'),
          content: const Text('Do you want to save your username and password for future logins?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Don't save data
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Save data
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    ) ?? false; // Default to false if dialog is dismissed

    if (saveData) {
      _saveLoginData();
    } else {
      _clearLoginData();
    }
  }

  // Save the username and password to EncryptedSharedPreferences
  void _saveLoginData() async {
    await encryptedPrefs.setString('username', _loginController.text);
    await encryptedPrefs.setString('password', _passwordController.text);
    print('Login data saved');
  }

  // Clear the saved login data from EncryptedSharedPreferences
  void _clearLoginData() async {
    await encryptedPrefs.remove('username');
    await encryptedPrefs.remove('password');
    print('Login data cleared');
  }

  // Handle the login button click event
  void _login() {
    _showSaveDialog();
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
              TextField(
                controller: _loginController,
                decoration: const InputDecoration(labelText: 'Login Name'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Login'),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
