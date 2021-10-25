import 'package:book_store_management/data/AllBooks.dart';
import 'package:book_store_management/data/Book.dart';
import 'package:book_store_management/ui/custom_widgets/IntNumberInputField.dart';
import 'package:book_store_management/ui/custom_widgets/ShowDialogs.dart';
import 'package:flutter/material.dart';

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

  int _bookId = AllBooks.getFirstBookId();

  void updateBookDataUI() {
    _inputsControllers["bookName"].text = _curBook?.name;
    _inputsControllers["bookAuthor"].text = _curBook?.author;
    _inputsControllers["bookPrice"].text = _curBook?.price.toString();
    _inputsControllers["bookCount"].text = _curBook?.count.toString();
  }

  void showBookData() {
    _curBook = AllBooks.getBookById(_bookId);

    if (_curBook == null) {
      ShowDialogs.showToast("The Book ID does not exist");
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


  Widget getSeparator() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: Container(
        padding: EdgeInsets.all(1),
        color: Colors.black,
      ),
    );
  }

  Widget getBookIdInputUI() {
    EdgeInsets insets = EdgeInsets.symmetric(horizontal: 15, vertical: 1);
    EdgeInsets buttonInsets = EdgeInsets.only(top: 20);

    _inputsControllers["bookId"] = TextEditingController();

    return Column(
      children: [

        Padding(padding: buttonInsets),

        Padding(
          padding: insets,
          child: IntNumberInputField(
            sideLabel: "Enter a book ID:",
            spaceAfterLabel: 15,
            minValue: AllBooks.getFirstBookId(),
            maxValue: AllBooks.getLastBookId(),
            value: this._bookId,
            onValueChanged: (int newValue) {
              this._bookId = newValue;
            },
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
          getSeparator(),
          getBookDataUI(),
        ],
      ),
    );
  }
}