import 'package:book_store_management/data/AllBooks.dart';
import 'package:book_store_management/ui/custom_widgets/ShowDialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class AddBookScreen extends StatefulWidget {
  const AddBookScreen({ Key? key }) : super(key: key);

  @override
  _AddBookScreenState createState() => _AddBookScreenState();
  

  static AddBookScreen getNewObject() {
    return AddBookScreen();
  }
}

class _AddBookScreenState extends State<AddBookScreen> {

  Map _textFieldControllers = {};
  var a = TextEditingController();

  _AddBookScreenState() {
    _textFieldControllers["bookName"] = TextEditingController();
    _textFieldControllers["bookAuthor"] = TextEditingController();
    _textFieldControllers["bookPrice"] = TextEditingController();
    _textFieldControllers["bookCount"] = TextEditingController();
  }


  List<Widget> getTextInputs() {
    EdgeInsets p = EdgeInsets.symmetric(horizontal: 15, vertical: 1);

    return <Widget>[
      Padding(
        padding: p,
        child: TextField(
          controller: _textFieldControllers["bookName"],
          decoration: new InputDecoration(labelText: "Enter book name"),
        ),
      ),

      Padding(
        padding: p,
        child: TextField(
          controller: _textFieldControllers["bookAuthor"],
          decoration: new InputDecoration(labelText: "Enter book author"),
        ),
      ),

      Padding(
        padding: p,
        child: TextField(
          controller: _textFieldControllers["bookPrice"],
          decoration: new InputDecoration(labelText: "Enter book price"),
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly
          ],
        ),
      ),

      Padding(
        padding: p,
        child: TextField(
          controller: _textFieldControllers["bookCount"],
          decoration: new InputDecoration(labelText: "Enter count of book"),
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly
          ],
        ),
      ),
    ];
  }

  Widget getSubmitButton() {
    EdgeInsets p = EdgeInsets.symmetric(horizontal: 15, vertical: 15);
    return Padding(
      padding: p,
      child: ElevatedButton(
        onPressed: () { this.addBook(); }, 
        child: Text("Add book")
      )
    );
  }

  void addBook() {
    String textBookName = _textFieldControllers["bookName"].text;
    String textBookAuthor = _textFieldControllers["bookAuthor"].text;
    String textBookPrice = _textFieldControllers["bookPrice"].text;
    String textBookCount = _textFieldControllers["bookCount"].text;

    if (textBookName == "" || textBookAuthor == "" || textBookPrice == "" || textBookCount == "") {
      ShowDialogs.showToast("Enter all the inputs");
    }

    int bookPrice = int.parse(textBookPrice);
    int bookCount = int.parse(textBookCount);

    bool bookAdded = AllBooks.addBook(textBookName, textBookAuthor, bookPrice, bookCount);

    if (bookAdded) {
      ShowDialogs.showToast("Book added");
    } else {
      ShowDialogs.showToast("Couldn't add book");
    }
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> colWidgets = getTextInputs();
    colWidgets.add(getSubmitButton());

    return Scaffold(
      appBar: AppBar(
        title: Text("Add book"),
      ),
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: colWidgets,
      ),
    );
  }
}