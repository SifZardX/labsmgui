import 'package:flutter/material.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  final String username;

  const ProfilePage({Key? key, required this.username}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;

  final EncryptedSharedPreferences _encryptedPrefs = EncryptedSharedPreferences();

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    _loadData();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    String? firstName = await _encryptedPrefs.getString('firstName');
    String? lastName = await _encryptedPrefs.getString('lastName');
    String? phone = await _encryptedPrefs.getString('phone');
    String? email = await _encryptedPrefs.getString('email');

    if (firstName != null) _firstNameController.text = firstName;
    if (lastName != null) _lastNameController.text = lastName;
    if (phone != null) _phoneController.text = phone;
    if (email != null) _emailController.text = email;
  }

  Future<void> _saveData() async {
    await _encryptedPrefs.setString('firstName', _firstNameController.text);
    await _encryptedPrefs.setString('lastName', _lastNameController.text);
    await _encryptedPrefs.setString('phone', _phoneController.text);
    await _encryptedPrefs.setString('email', _emailController.text);
    _showSnackbar('Profile saved!');
  }

  void _callNumber() async {
    final String phoneNumber = _phoneController.text;
    final Uri url = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      _showAlertDialog('This device cannot make calls.');
    }
  }

  void _sendSMS() async {
    final String phoneNumber = _phoneController.text;
    final Uri url = Uri(scheme: 'sms', path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      _showAlertDialog('This device cannot send SMS.');
    }
  }

  void _sendEmail() async {
    final String email = _emailController.text;
    final Uri url = Uri(scheme: 'mailto', path: email);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      _showAlertDialog('This device cannot send emails.');
    }
  }

  void _showAlertDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome Back, ${widget.username}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _firstNameController,
              decoration: const InputDecoration(labelText: 'First Name', border: OutlineInputBorder()),
            ),
            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(labelText: 'Last Name',border: OutlineInputBorder()),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _phoneController,
                    decoration: const InputDecoration(labelText: 'Phone Number', border: OutlineInputBorder()),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.call),
                  onPressed: _callNumber,
                ),
                IconButton(
                  icon: const Icon(Icons.message),
                  onPressed: _sendSMS,
                ),
              ],
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email Address',border: OutlineInputBorder()),
            ),
            IconButton(
              icon: const Icon(Icons.mail),
              onPressed: _sendEmail,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _saveData();
              },
              child: const Text('Save Profile'),
            ),
          ],
        ),
      ),
    );
  }
}