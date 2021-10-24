import 'package:book_store_management/data/AllBooks.dart';
import 'package:book_store_management/data/Book.dart';
import 'package:book_store_management/ui/custom_widgets/ShowDialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditBookScreen extends StatefulWidget {
  const EditBookScreen({ Key? key }) : super(key: key);

  @override
  _EditBookScreenState createState() => _EditBookScreenState();

  static EditBookScreen getNewObject() {
    return EditBookScreen();
  }
}

class _EditBookScreenState extends State<EditBookScreen> {
  
  Map _inputsControllers = {};
  Book? _curBook;

  void updateBookDataUI() {
    _inputsControllers["bookName"].text = _curBook?.name;
    _inputsControllers["bookAuthor"].text = _curBook?.author;
    _inputsControllers["bookPrice"].text = _curBook?.price.toString();
    _inputsControllers["bookCount"].text = _curBook?.count.toString();
  }

  void showBookData() {
    String bookIdText = _inputsControllers["bookId"].text;

    if (bookIdText == "") {
      ShowDialogs.showToast("Enter the sr. no. of a book");
      return;
    }

    int bookId = int.parse(bookIdText) - 1;
    _curBook = AllBooks.getBookByNum(bookId);

    if (_curBook == null) {
      ShowDialogs.showToast("The sr. no. does not exist");
      return;
    }

    updateBookDataUI();
  }

  void updateBookData() {
    if (_curBook == null) {
      ShowDialogs.showToast("No book is selected");
    }

    String bookName = _inputsControllers["bookName"].text;
    String bookAuthor = _inputsControllers["bookAuthor"].text;
    String bookPrice = _inputsControllers["bookPrice"].text;
    String bookCount = _inputsControllers["bookCount"].text;

    if (bookName.isEmpty || bookAuthor.isEmpty || bookPrice.isEmpty || bookCount.isEmpty) {
      ShowDialogs.showToast("Enter proper inputs");
      return;
    }

    _curBook?.name = bookName;
    _curBook?.author = bookAuthor;
    _curBook?.price = int.parse(bookPrice);
    _curBook?.count = int.parse(bookCount);

    ShowDialogs.showToast("Book data updated");
  }


  Widget getBookIdInputUI() {
    EdgeInsets insets = EdgeInsets.symmetric(horizontal: 15, vertical: 1);
    EdgeInsets buttonInsets = EdgeInsets.only(top: 20);

    _inputsControllers["bookId"] = TextEditingController();

    return Column(
      children: [

        // TODO: Change to IntNumberInputField
        Padding(
          padding: insets,
          child: TextField(
            controller: _inputsControllers["bookId"],
            decoration: new InputDecoration(labelText: "Book ID"),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
        ),

        Padding(
          padding: buttonInsets,
          child: ElevatedButton(
            onPressed: showBookData,
            child: Text("Get data")
          ),
        ),
      ]
    );
  }


  Widget getBookDataUI() {
    EdgeInsets insets = EdgeInsets.symmetric(horizontal: 15, vertical: 1);
    EdgeInsets buttonInsets = EdgeInsets.only(top: 20);
    
    _inputsControllers["bookName"] = TextEditingController();
    _inputsControllers["bookAuthor"] = TextEditingController();
    _inputsControllers["bookPrice"] = TextEditingController();
    _inputsControllers["bookCount"] = TextEditingController();

    return Column(
      children: [
        Padding(
          padding: insets,
          child: TextField(
            controller: _inputsControllers["bookName"],
            decoration: new InputDecoration(labelText: "Book Name"),
          ),
        ),
        Padding(
          padding: insets,
          child: TextField(
            controller: _inputsControllers["bookAuthor"],
            decoration: new InputDecoration(labelText: "Book Author"),
          ),
        ),
        Padding(
          padding: insets,
          child: TextField(
            controller: _inputsControllers["bookPrice"],
            decoration: new InputDecoration(labelText: "Book Price"),
          ),
        ),

        Padding(
          padding: insets,
          child: TextField(
            controller: _inputsControllers["bookCount"],
            decoration: new InputDecoration(labelText: "Book Count"),
          ),
        ),

        Padding(
          padding: buttonInsets,
          child: ElevatedButton(
            onPressed: updateBookData,
            child: Text("Update Book")
          ),
        ),
      ],
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit book"),),
      body: ListView(
        children: [
          getBookIdInputUI(),
          getBookDataUI(),
        ],
      ),
    );
  }
}