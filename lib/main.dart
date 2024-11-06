import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Categories Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Food Categories Page'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.jpg'),  // Your background image here
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Title Row (Centered)
                const Text(
                  'By Course',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),

                // By Course Images Row (Space Between)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildCategoryImage('images/baconegg.JPG', 'Breakfast'),
                    _buildCategoryImage('images/lunch.png', 'Lunch'),
                    _buildCategoryImage('images/dinner.png', 'Dinner'),
                    _buildCategoryImage('images/appetizer.png', 'Appetizer'),
                  ],
                ),
                const SizedBox(height: 20),

                // "By Meat" Section
                const Text(
                  'By Meat',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildCategoryImage('images/beef.jpg', 'Beef'),
                    _buildCategoryImage('images/chicken.jpg', 'Chicken'),
                    _buildCategoryImage('images/pork.png', 'Pork'),
                    _buildCategoryImage('images/seafood.jpg', 'Seafood'),
                  ],
                ),
                const SizedBox(height: 20),

                // "By Dessert" Section
                const Text(
                  'By Dessert',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildCategoryImage('images/browns.png', 'Brownies'),
                    _buildCategoryImage('images/piess.jpg', 'Pies'),
                    _buildCategoryImage('images/cookies.jpg', 'Cookies'),
                    _buildCategoryImage('images/icecream.jpg', 'Ice Cream'),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper function to build the category images with text overlay
  Widget _buildCategoryImage(String imagePath, String label) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(imagePath),
              radius: 50,
            ),
            Positioned(
              bottom: 5,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                color: Colors.black.withOpacity(0.5),
                child: Text(
                  label,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
