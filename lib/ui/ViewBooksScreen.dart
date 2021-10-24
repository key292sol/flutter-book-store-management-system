import 'package:book_store_management/data/AllBooks.dart';
import 'package:flutter/material.dart';

class ViewBooksScreen extends StatefulWidget {
  const ViewBooksScreen({ Key? key }) : super(key: key);

  @override
  _ViewBooksScreenState createState() => _ViewBooksScreenState();

  static ViewBooksScreen getNewObject() {
    return ViewBooksScreen();
  }
}

class _ViewBooksScreenState extends State<ViewBooksScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Books"),
      ),
      body: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: DataTable(
              columns: AllBooks.getDataTableColumns(),
              rows: AllBooks.getAllBooksAsDataTableRows(),
            ),
          ),
        ),
      ),
    );
  }
}