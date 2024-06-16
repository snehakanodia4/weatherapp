import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'NextScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _locationController;
  bool _rememberMe = true;
  bool _isLoading = true; // Variable to check if preferences are loaded

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _locationController = TextEditingController();
    _loadPreferences();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  // Method to load the shared preference data
  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _rememberMe = prefs.getBool('rememberMe') ?? true;
      if (_rememberMe) {
        _usernameController.text = prefs.getString('username') ?? '';
        _emailController.text = prefs.getString('E-mail') ?? '';
        _locationController.text = prefs.getString('location') ?? '';
      }
      _isLoading = false;
    });
  }

  Future<void> _savePreferencesAndNavigate(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    if (_rememberMe) {
      prefs.setString('username', _usernameController.text);
      prefs.setString('E-mail', _emailController.text);
      prefs.setString('location', _locationController.text);
    } else {
      prefs.remove('username');
      prefs.remove('E-mail');
      prefs.remove('location');
    }
    prefs.setBool('rememberMe', _rememberMe);

    // Navigate to the next screen
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              NextScreen(initialLocation: _locationController.text)),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      // Show a loading indicator while preferences are being loaded
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 240, 198, 0.875),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 227, 182, 2),
        title: Text('PLEASE COMPLETE YOUR PROFILE!'),
        titleTextStyle: TextStyle(
          color: Colors.deepPurple,
          fontSize: 35,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                labelStyle: TextStyle(fontSize: 25),
                hintText: 'Enter your Name',
              ),
              onChanged: (value) {
                setState(() {
                  // This is needed only if you want to perform some state change based on input
                });
              },
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'E-mail',
                labelStyle: TextStyle(fontSize: 25),
                hintText: 'Enter your E-mail ID',
              ),
              onChanged: (value) {
                setState(() {
                  // This is needed only if you want to perform some state change based on input
                });
              },
            ),
            TextField(
              controller: _locationController,
              decoration: InputDecoration(
                labelText: 'Location',
                labelStyle: TextStyle(fontSize: 25),
                hintText: 'Enter your Location',
              ),
              onChanged: (value) {
                setState(() {
                  // This is needed only if you want to perform some state change based on input
                });
              },
            ),
            CheckboxListTile(
              title: Text('Remember me'),
              value: _rememberMe,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value!;
                });
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 227, 182, 2),
                  textStyle:
                      TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              child: Text('Save and Next'),
              onPressed: () => _savePreferencesAndNavigate(context),
            ),
          ],
        ),
      ),
    );
  }
}
