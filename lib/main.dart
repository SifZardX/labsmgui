import 'package:flutter/material.dart';

void main() => runApp(TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  // List to store items
  List<String> words = [];
  // Controller for the TextField input
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("To-Do List")),
      body: Column(
        children: [
          // Row with TextField and Add Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                child: Text("Add item"),
                onPressed: () {
                  setState(() {
                    words.add(_controller.text);
                    _controller.clear();
                  });
                },
              ),
              // TextField for user input
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: "Enter new item",
                  ),
                ),
              ),
            ],
          ),
          // Expanded ListView inside Column
          Expanded(
            child: words.isEmpty
                ? Center(child: Text("There are no items in the list"))
                : ListView.builder(
              itemCount: words.length,
              itemBuilder: (context, rowNum) {
                return GestureDetector(
                  onLongPress: () {
                    _showDeleteDialog(rowNum);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Row number: $rowNum"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(words[rowNum]),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Function to show dialog on long press
  void _showDeleteDialog(int rowNum) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Item"),
          content: Text("Are you sure you want to delete this item?"),
          actions: [
            TextButton(
              child: Text("No"),
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog without deleting
              },
            ),
            TextButton(
              child: Text("Yes"),
              onPressed: () {
                setState(() {
                  words.removeAt(rowNum); // Delete item
                });
                Navigator.of(context).pop(); // Close dialog after deleting
              },
            ),
          ],
        );
      },
    );
  }
}
