import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Recipe Categories'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between items in the column
          children: <Widget>[
            // Row 1: Left-aligned text
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text('By Course', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 10),

            // Row 2: Image Row (Beef, Chicken, Pork, Seafood)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround, // Space around images
              children: [
                _buildImageWithText('images/beef.jpg', 'Beef'),
                _buildImageWithText('images/chicken.jpg', 'Chicken'),
                _buildImageWithText('images/pork.jpg', 'Pork'),
                _buildImageWithText('images/seafood.jpg', 'Seafood'),
              ],
            ),
            const SizedBox(height: 10),

            // Row 3: Image Stack (Main dishes, Salad Recipes, etc.)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround, // Space around images
              children: [
                _buildStackImage('images/maindishes.jpg', 'Main Dishes'),
                _buildStackImage('images/salad.jpg', 'Salad Recipes'),
                _buildStackImage('images/sidedishes.jpg', 'Side Dishes'),
                _buildStackImage('images/crockpot.jpg', 'Crockpot'),
              ],
            ),
            const SizedBox(height: 10),

            // Row 4: Dessert Row with Stack
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround, // Space around images
              children: [
                _buildStackImage('images/icecream.jpg', 'Ice Cream'),
                _buildStackImage('images/brownies.jpg', 'Brownies'),
                _buildStackImage('images/pies.jpg', 'Pies'),
                _buildStackImage('images/cookies.jpg', 'Cookies'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to create an image with centered text
  Widget _buildImageWithText(String imagePath, String text) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(imagePath),
          radius: 50,  // Set the radius of the CircleAvatar to make the circle frame
        ),
        const SizedBox(height: 5),
        Text(text),
      ],
    );
  }

  // Helper method to create a Stack widget with text on top of image
  Widget _buildStackImage(String imagePath, String text) {
    return Stack(
      alignment: Alignment.bottomCenter,  // Position the text at the bottom center
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(imagePath),
          radius: 50,  // Set the radius of the CircleAvatar to make the circle frame
        ),
        Positioned(
          bottom: 10,  // Adjust text position to make it appear at the bottom
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
