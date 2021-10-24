import 'package:book_store_management/AddBooks.dart';
import 'package:book_store_management/ui/HomePage.dart';
import 'globals.dart';
import 'package:flutter/material.dart';

void main() {
  addMultiBooks();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: snackbarKey,
      title: 'Book Store Management System',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

