import 'package:book_store_management/globals.dart';
import 'package:book_store_management/ui/AddBookScreen.dart';
import 'package:book_store_management/ui/EditBookScreen.dart';
import 'package:book_store_management/ui/SellBookScreen.dart';
import 'package:book_store_management/ui/custom_widgets/IntNumberInputField.dart';
import 'package:book_store_management/ui/RemoveBookScreen.dart';
import 'package:book_store_management/ui/SearchBookScreen.dart';
import 'package:book_store_management/ui/ViewBooksScreen.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  EdgeInsets _myInsets = EdgeInsets.symmetric(vertical: 20, horizontal: 10);

  Widget getTitleWidget() {
    return Padding(
      padding: _myInsets,
      child: Text(
        "Book Store Management System",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 40
        ),
      ),
    );
  }

  Widget getPadding() {
    return Container(padding: EdgeInsets.only(top: 0));
  }

  List<Widget> getPageButtons() {
    Map pagesMap = {
      "View all books": ViewBooksScreen.getNewObject,
      "Add a book": AddBookScreen.getNewObject,
      "Delete book": RemoveBookScreen.getNewObject,
      "Search books": SearchBookScreen.getNewObject,
      "Edit a book": EditBookScreen.getNewObject,
      "Sell book": SellBookScreen.getNewObject
    };
    
    ButtonStyle buttonStyle = ButtonStyle();
    TextStyle buttonTextStyle = TextStyle(
      fontSize: 25,
      color: Color.fromRGBO(0, 0, 0, 0.7)
    );

    return pagesMap.entries.map((entry) {
      return Padding(
        padding: _myInsets,
        child: TextButton(
          onPressed: () => navigateToScreen(entry.value()),
          child: Text(
            entry.key,
            style: buttonTextStyle,
          ),
          style: buttonStyle,
        ),
      );
    }).toList();
  }



  List<Widget> getHomePageColumnList() {
    List<Widget> column = [];
    column.add(getTitleWidget());
    column.add(getPadding());
    column.addAll(getPageButtons());
    return column;
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Home Page"),),
      body: SingleChildScrollView(
        child: Column(
          children: getHomePageColumnList(),
          /* [
            Padding(
              padding: _myInsets,
              child: Text(
                "Book Store Management System",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40
                ),
              ),
            ),

            Container(padding: EdgeInsets.only(top: 0)),

            /* Padding(
              padding: insets,
              child: SizedBox.fromSize(
                size: Size(150, 40),
                child: getNumberField(),
              )
            ), */

            Padding(
              padding: _myInsets,
              child: TextButton(
                onPressed: () => navigateToScreen(context, ViewBooksScreen()),
                child: Text(
                  "View all books",
                  style: buttonTextStyle,
                ),
                style: buttonStyle,
              ),
            ),

            Padding(
              padding: _myInsets,
              child: TextButton(
                onPressed: () => navigateToScreen(context, AddBookScreen()),
                child: Text(
                  "Add a book",
                  style: buttonTextStyle,
                ),
                style: buttonStyle,
              ),
            ),

            Padding(
              padding: _myInsets,
              child: TextButton(
                onPressed: () => navigateToScreen(context, RemoveBookScreen()),
                child: Text(
                  "Delete books",
                  style: buttonTextStyle,
                ),
                style: buttonStyle,
              ),
            ),

            Padding(
              padding: _myInsets,
              child: TextButton(
                onPressed: () => navigateToScreen(context, SearchBookScreen()),
                child: Text(
                  "Search books",
                  style: buttonTextStyle,
                ),
                style: buttonStyle,
              ),
            ),

            Padding(
              padding: _myInsets,
              child: TextButton(
                onPressed: () => navigateToScreen(context, EditBookScreen()),
                child: Text(
                  "Edit a book",
                  style: buttonTextStyle,
                ),
                style: buttonStyle,
              ),
            ),

            Padding(
              padding: _myInsets,
              child: TextButton(
                onPressed: () => navigateToScreen(context, EditBookScreen()),
                child: Text(
                  "Sell a book",
                  style: buttonTextStyle,
                ),
                style: buttonStyle,
              ),
            ),
          ], */
        ),
      )
    );
  }


  Widget getNumberField() {
    IntNumberInputField nif = IntNumberInputField();
    // nif.setLabelText("Label");
    return nif;
  }

}