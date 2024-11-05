import 'package:flutter/material.dart';

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
  // Step 1: Change _counter variable to use 'var' instead of 'double'
  var _counter = 0.0; // Initialize _counter as a double using var
  var myFontSize = 30.0; // Step 2: Declare myFontSize variable

  // Step 4: Modify setNewValue to also change the font size
  void _incrementCounter(double newValue) {
    setState(() {
      _counter = newValue;
      myFontSize = newValue; // Adjust font size as well when the slider changes
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Text showing the number of times the button is pressed
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter', // Show the current counter value
              style: TextStyle(fontSize: myFontSize), // Use myFontSize for font size
            ),
            Slider(
              value: _counter,
              min: 0.0,
              max: 100.0,
              divisions: 100,
              onChanged: (double newValue) {
                _incrementCounter(newValue); // Update both _counter and myFontSize
              },
            ),
            Text(
              'Font Size: ${myFontSize.toStringAsFixed(2)}', // Display current font size
              style: TextStyle(fontSize: myFontSize), // Update font size
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Use the slider's value for both counter and font size change
          setState(() {
            _counter++;
            myFontSize = _counter; // Set the font size equal to the counter value
          });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
