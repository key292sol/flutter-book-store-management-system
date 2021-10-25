import 'package:book_store_management/data/AllBooks.dart';
import 'package:book_store_management/data/Book.dart';
import 'package:book_store_management/globals.dart';
import 'package:book_store_management/ui/custom_widgets/IntNumberInputField.dart';
import 'package:book_store_management/ui/custom_widgets/ShowDialogs.dart';
import 'package:flutter/material.dart';

class SellBookScreen extends StatefulWidget {
  const SellBookScreen({ Key? key }) : super(key: key);

  @override
  _SellBookScreenState createState() => _SellBookScreenState();

  static SellBookScreen getNewObject() {
    return SellBookScreen();
  }
}

class _SellBookScreenState extends State<SellBookScreen> {

  Book _curBook = Book(-1, "", "", 0, 0);
  int _bookId = AllBooks.getFirstBookId();
  int _sellingPrice = 0;
  int _sellingCount = 0;

  void getBookByID() {
    Book? book = AllBooks.getBookById(_bookId);

    if (book == null) {
      ShowDialogs.showToast("No book found with this ID");
      return;
    }

    setState(() {
      this._sellingCount = 0;
      this._sellingPrice = 0;
      this._curBook = book;
    });
  }

  void sellBook() {
    if (_curBook.count == 0) {
      return;
    }

    _curBook.count -= this._sellingCount;

    ShowDialogs.showToast("Sold $_sellingCount books");

    /* setState(() {
      this._bookId = AllBooks.getFirstBookId();
      this._curBook = Book(-1, "", "", 0, 0);
      this._sellingCount = 0;
      this._sellingPrice = 0;
    }); */

    navigatePop();
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

  Widget getBookIdInputUI() {
    EdgeInsets insets = EdgeInsets.symmetric(horizontal: 15, vertical: 1);
    EdgeInsets buttonInsets = EdgeInsets.symmetric(horizontal: 15, vertical: 10);

    _bookId = AllBooks.getFirstBookId();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 15),
          child: Text(
            "Select Book ID",
            textAlign: TextAlign.center,
            style: getHeadTextStyle(),
          ),
        ),

        Padding(
          padding: insets,
          child: IntNumberInputField(
            minValue: _bookId,
            maxValue: AllBooks.getLastBookId(),
            value: AllBooks.getFirstBookId(),
            onValueChanged: (int newVal) {
              this._bookId = newVal;
            },
          ),
        ),

        Padding(
          padding: buttonInsets,
          child: ElevatedButton(
            onPressed: this.getBookByID,
            child: Text(
              "Load data",
              style: getContentTextStyle(),
            )
          ),
        ),
      ]
    );
  }

  Widget getBookDataUI() {
    EdgeInsets insets = EdgeInsets.symmetric(horizontal: 15, vertical: 10);
    TextStyle textStyle = getContentTextStyle();

    Map curBookMap = (_curBook.id == -1) ? Book.getEmptyMap() : _curBook.getAsMap();

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: insets,
            child: Text(
              "Book Data:",
              textAlign: TextAlign.center,
              style: getHeadTextStyle(),
            ),
          ),

          
          Padding(
            padding: insets,
            child: Text(
              "Book ID: " + curBookMap["id"],
              style: textStyle,
            ),
          ),
          Padding(
            padding: insets,
            child: Text(
              "Book Name: " + curBookMap["name"],
              style: textStyle,
            ),
          ),
          Padding(
            padding: insets,
            child: Text(
              "Book Author: " + curBookMap["author"],
              style: textStyle,
            ),
          ),
          Padding(
            padding: insets,
            child: Text(
              "Book Price: " + curBookMap["price"],
              style: textStyle,
            ),
          ),
          /* Padding(
            padding: insets,
            child: Text(
              "Total count: " + _curBook.count.toString(),
              style: textStyle,
            ),
          ), */
        ],
      )
    );
  }

  Widget getSellingUI() {
    EdgeInsets insets = EdgeInsets.symmetric(horizontal: 15, vertical: 1);
    TextStyle textStyle = getContentTextStyle();
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: insets,
            child: Text(
              "Sell Book",
              textAlign: TextAlign.center,
              style: getHeadTextStyle(),
            ),
          ),
          Container(
            child: Row(
              children: [
                Padding(
                  padding: insets,
                  child: Text(
                    "Number of books:",
                    style: textStyle,
                  ),
                ),
                Padding(
                  padding: insets,
                  child: IntNumberInputField(
                    minValue: 0,
                    // maxValue: (_curBook != null) ? _curBook!.count : 0,
                    maxValue: _curBook.count,
                    value: this._sellingCount,
                    onValueChanged: (int newCount) {
                      // int price = (_curBook != null) ? _curBook!.price : 0;
                      int price = _curBook.price;

                      this._sellingCount = newCount;

                      setState(() {
                        this._sellingPrice = price * _sellingCount;
                      });

                    },
                  )
                ),
                
              ],
            ),
          ),

          Padding(
            padding: insets,
            child: Text(
              "Total cost: " + this._sellingPrice.toString(),
              style: textStyle,
            ),
          ),

          Padding(padding: insets),

          Container(
            margin: EdgeInsets.only(top: 10),
            padding: insets,
            child: ElevatedButton(
              child: Text(
                "Sell",
                style: textStyle,
              ),
              onPressed: this.sellBook,
            ),
          ),

        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sell a book"),),
      body: ListView(
        children: [
          getBookIdInputUI(),
          getSeparator(),
          getBookDataUI(),
          getSeparator(),
          getSellingUI()
        ],
      ),
    );
  }
}