import 'package:book_store_management/data/AllBooks.dart';
import 'package:book_store_management/data/Book.dart';
import 'package:book_store_management/globals.dart';
import 'package:book_store_management/ui/custom_widgets/IntNumberInputField.dart';
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

class _RemoveBookScreenState extends State<RemoveBookScreen> {

  Map<String, TextEditingController> _inputControllers = {};
  List<Function> _inputUIFunctions = [];
  int? _dropDownValue = 0;
  int _bookId= AllBooks.getFirstBookId();

  Book? _curBook;

  late Widget _getDataInputUI;

  _RemoveBookScreenState() {
    _inputControllers["bookId"] = TextEditingController();
    _inputControllers["bookName"] = TextEditingController();
    _inputControllers["bookAuthor"] = TextEditingController();

    _inputUIFunctions.add(this.getRemoveByIdUI);
    _inputUIFunctions.add(this.getBookNameNAuthorUI);

    _dropDownValue = 0;
    _getDataInputUI = _inputUIFunctions[0]();
  }

  void showDeletedToast(bool wasDeleted) {
    String toastMsg = (wasDeleted) ? "Book deleted" : "Book not found";
    ShowDialogs.showToast(toastMsg);
  }

  void showBookFoundToast(bool wasFound) {
    String toastMsg = (wasFound) ? "Book found" : "Book not found";
    ShowDialogs.showToast(toastMsg);
  }

  void setCurBook(Book? book) {
    bool wasBookFound = (book != null);

    if (!wasBookFound) {
      showBookFoundToast(wasBookFound);
    }

    setState(() {
      _curBook = book;
    });
  }

  void getBookData() {
    switch (this._dropDownValue) {
      case 0:
        this.getBookDataById();
        break;
      case 1:
        this.getBookDataByNameNAuthor();
        break;
      default:
        print("Invalid dropdown value");
    }
  }

  void getBookDataById() {
    Book? book = AllBooks.getBookById(this._bookId);
    setCurBook(book);
  }

  void getBookDataByNameNAuthor() {
    String bookName = _inputControllers["bookName"]!.text;
    String bookAuthor = _inputControllers["bookAuthor"]!.text;

    if (bookName == "" || bookAuthor == "") {
      ShowDialogs.showToast("Enter all the inputs");
      return;
    }

    List<Book> books = AllBooks.getSearchedBooks(bookName: bookName, author: bookAuthor);

    if (books.length == 0) {
      setCurBook(null);
    } else {
      setCurBook(books[0]);
    }
  }

  void deleteBook() {
    if (this._curBook == null) {
      ShowDialogs.showToast("No book is selected");
      return;
    }

    int id = this._curBook!.id;
    bool wasDeleted = AllBooks.deleteBookById(id);

    showDeletedToast(wasDeleted);
    navigatePop();

    /* if (wasDeleted) {
      setState(() {
        _curBook = null;
        _bookId = AllBooks.getFirstBookId();
        int i = _dropDownValue!.toInt();
        _getDataInputUI = _inputUIFunctions[i]();
      });
    } */
  }

  void setDeleteType(int? newValue) {
    setState(() {
      int index = (newValue == null) ? 0 : newValue;

      _dropDownValue = newValue;
      _getDataInputUI = _inputUIFunctions[index]();
    });
  }

  TextStyle getHeadTextStyle() {
    return TextStyle(
      fontSize: 25,
    );
  }

  TextStyle getContentTextStyle() {
    return TextStyle(
      fontSize: 17,
    );
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

  Widget getChooserUI() {
    EdgeInsets insets = EdgeInsets.symmetric(horizontal: 15, vertical: 1);

    TextStyle contentTextStyle = getContentTextStyle();

    List<String> dropdownOptions = ["Book ID", "Book Name and Author"];
    int i = 0;

    return Container(
      child: Column(
        children: [
          /* Padding(
            padding: insets,
            child: Text(
              "Choose",
              style: getHeadTextStyle(),
            )
          ), */

          Container(
            child: Row(
              children: [
                Padding(
                  padding: insets,
                  child: Text(
                    "Delete By: ",
                    style: contentTextStyle,
                  ),
                ),

                Padding(
                  padding: insets,
                  child: DropdownButton<int>(
                    items: dropdownOptions.map<DropdownMenuItem<int>>((e) {
                      return DropdownMenuItem(
                        child: Text(e),
                        value: i++,
                      );
                    }).toList(),
                    onChanged: this.setDeleteType,
                    value: this._dropDownValue,
                  )
                ),
                
              ],
            ),
          )

        ],
      ),
    );
  }

  Widget getRemoveByIdUI() {
    EdgeInsets insets = EdgeInsets.symmetric(horizontal: 15, vertical: 1);

    return Container(
      child: Column(
        children: [
          Padding(
            padding: insets,
            child: Text(
              "Select Book ID",
              style: getHeadTextStyle(),
            ),
          ),
          
          Padding(
            padding: insets,
            child: IntNumberInputField(
              sideLabel: "Enter a book ID: ",
              sideLabelTextStyle: getContentTextStyle(),
              minValue: AllBooks.getFirstBookId(),
              maxValue: AllBooks.getLastBookId(),
              value: this._bookId,
              onValueChanged: (int newValue) {
                this._bookId = newValue;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget getBookNameNAuthorUI() {
    EdgeInsets insets = EdgeInsets.symmetric(horizontal: 15, vertical: 1);

    return Container(
      child: Column(
        children: [
          Padding(
            padding: insets,
            child: Text(
              "Enter Book Name and Author",
              style: getHeadTextStyle(),
            ),
          ),
          
          Padding(
            padding: insets,
            child: TextField(
              controller: _inputControllers["bookName"],
              decoration: new InputDecoration(labelText: "Enter book name"),
            ),
          ),

          Padding(
            padding: insets,
            child: TextField(
              controller: _inputControllers["bookAuthor"],
              decoration: new InputDecoration(labelText: "Enter book author"),
            ),
          ),
        ],
      ),
    );
  }

  Widget getBookDataUI() {
    EdgeInsets insets = EdgeInsets.symmetric(horizontal: 15, vertical: 1);
    TextStyle contentTextStyle = getContentTextStyle();

    Map<String, String> curBookMap;

    if (_curBook == null) {
      curBookMap = Book.getEmptyMap();
    } else {
      curBookMap = _curBook!.getAsMap();
    }

    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: insets,
            child: Text(
              "Book Info",
              style: getHeadTextStyle(),
            ),
          ),

          Padding(
            padding: insets,
            child: Text(
              "Book ID: " + curBookMap["id"].toString(),
              style: contentTextStyle,
            ),
          ),
          Padding(
            padding: insets,
            child: Text(
              "Book Name: " + curBookMap["name"].toString(),
              style: contentTextStyle,
            ),
          ),
          Padding(
            padding: insets,
            child: Text(
              "Book Author: " + curBookMap["author"].toString(),
              style: contentTextStyle,
            ),
          ),
          Padding(
            padding: insets,
            child: Text(
              "Book price: " + curBookMap["price"].toString(),
              style: contentTextStyle,
            ),
          ),
          Padding(
            padding: insets,
            child: Text(
              "Book count: " + curBookMap["count"].toString(),
              style: contentTextStyle,
            ),
          ),
        ],
      ),
    );
  }


  Widget getLoadDataButton() {
    EdgeInsets buttonInsets = EdgeInsets.only(top: 20);
    return Padding(
      padding: buttonInsets,
      child: ElevatedButton(
        onPressed: this.getBookData,
        child: Text("Load Book Data")
      ),
    );
  }

  Widget getDeleteButton() {
    EdgeInsets buttonInsets = EdgeInsets.only(top: 20);
    return Padding(
      padding: buttonInsets,
      child: ElevatedButton(
        onPressed: this.deleteBook,
        child: Text("Delete")
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delete a book"),
      ),
      body: ListView(
        children: [
          getChooserUI(),
          getSeparator(),

          this._getDataInputUI,
          getLoadDataButton(),
          getSeparator(),

          getBookDataUI(),
          getDeleteButton()
        ]
      ),
    );
  }
}