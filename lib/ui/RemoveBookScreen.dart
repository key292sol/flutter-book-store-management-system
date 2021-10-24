import 'package:book_store_management/data/AllBooks.dart';
import 'package:book_store_management/ui/custom_widgets/ShowDialogs.dart';
import 'package:flutter/material.dart';

class RemoveBookScreen extends StatefulWidget {
  const RemoveBookScreen({ Key? key }) : super(key: key);

  @override
  _RemoveBookScreenState createState() => _RemoveBookScreenState();

  static RemoveBookScreen getNewObject() {
    return RemoveBookScreen();
  }
}

// TODO: Remove book by ID
class _RemoveBookScreenState extends State<RemoveBookScreen> {

  TextEditingController _bookNameController = new TextEditingController();
  TextEditingController _bookAuthorController = new TextEditingController();


  void deleteBook() {
    String bookName = _bookNameController.text;
    String bookAuthor = _bookAuthorController.text;

    if (bookName == "" || bookAuthor == "") {
      ShowDialogs.showToast("Enter all the inputs");
      return;
    }

    bool delBooks = AllBooks.deleteBookByNameNAuthor(bookName, bookAuthor);

    String toastMsg = (delBooks) ? "Book deleted" : "Book not found";
    ShowDialogs.showToast(toastMsg);
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsets insets = EdgeInsets.symmetric(horizontal: 15, vertical: 1);
    EdgeInsets buttonInsets = EdgeInsets.only(top: 20);

    return Scaffold(
      appBar: AppBar(
        title: Text("Delete a book"),
      ),
      body: Column(
        children: [
          Padding(
            padding: insets,
            child: TextField(
              controller: _bookNameController,
              decoration: new InputDecoration(labelText: "Enter book name"),
            ),
          ),

          Padding(
            padding: insets,
            child: TextField(
              controller: _bookAuthorController,
              decoration: new InputDecoration(labelText: "Enter book author"),
            ),
          ),

          Padding(
            padding: buttonInsets,
            child: ElevatedButton(
              onPressed: this.deleteBook,
              child: Text("Delete")
            ),
          )
        ],
      ),
    );
  }
}