import 'package:book_store_management/data/AllBooks.dart';
import 'package:book_store_management/ui/custom_widgets/ShowDialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchBookScreen extends StatefulWidget {
  const SearchBookScreen({ Key? key }) : super(key: key);

  @override
  _SearchBookScreenState createState() => _SearchBookScreenState();

  static SearchBookScreen getNewObject() {
    return SearchBookScreen();
  }
}

class _SearchBookScreenState extends State<SearchBookScreen> {

  Map _inputsControllers = {};
  List<DataRow> _dataTableRows = [];
  int? _dropdownValue = 0;
  List<Function> _inputUIs = [];

  late Widget _searchInputUI;

  _SearchBookScreenState() {
    _searchInputUI = getBookIdSearchUI();

    _inputUIs.add(this.getBookIdSearchUI);
    _inputUIs.add(this.getNameAuthorSearchUI);

    _inputsControllers["bookName"] = TextEditingController();
    _inputsControllers["bookAuthor"] = TextEditingController();
  }


  void _setDataTableRows(List<DataRow> rows) {
    setState(() {
      this._dataTableRows = rows;
    });
  }

  void searchBookById() {
    String bookIdText = _inputsControllers["bookId"].text;

    if (bookIdText == "") {
      ShowDialogs.showToast("Enter a book number");
      return;
    }

    int bookId = int.parse(bookIdText) - 1;

    List<DataRow> rows = AllBooks.getOneBookAsDataRows(bookId);

    _setDataTableRows(rows);
  }

  void searchBookByNameNAuthor() {
    String bookName = _inputsControllers["bookName"].text;
    String bookAuthor = _inputsControllers["bookAuthor"].text;

    List<DataRow> r = AllBooks.getSearchBookAsDataRows(bookName: bookName, author: bookAuthor);

    _setDataTableRows(r);
  }


  void setSearchType(int? newValue) {
    setState(() {
      _dropdownValue = newValue;

      int index = (newValue == null) ? 0 : newValue;

      _searchInputUI = _inputUIs[index]();

      _dataTableRows = [];
    });
  }

  Widget getBookIdSearchUI() {
    EdgeInsets insets = EdgeInsets.symmetric(horizontal: 15, vertical: 1);
    EdgeInsets buttonInsets = EdgeInsets.only(top: 20);

    _inputsControllers["bookId"] = TextEditingController();

    return Column(
      children: [
        Padding(
          padding: insets,
          child: TextField(
            controller: _inputsControllers["bookId"],
            decoration: new InputDecoration(labelText: "Enter book ID"),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
        ),

        Padding(
          padding: buttonInsets,
          child: ElevatedButton(
            onPressed: () { searchBookById(); },
            child: Text("Search")
          ),
        ),
      ]
    );
  }

  Widget getNameAuthorSearchUI() {
    EdgeInsets insets = EdgeInsets.symmetric(horizontal: 15, vertical: 1);
    EdgeInsets buttonInsets = EdgeInsets.only(top: 20);

    return Column(
      children: [
        Padding(
          padding: insets,
          child: TextField(
            controller: _inputsControllers["bookName"],
            decoration: new InputDecoration(labelText: "Enter book name"),
          ),
        ),

        Padding(
          padding: insets,
          child: TextField(
            controller: _inputsControllers["bookAuthor"],
            decoration: new InputDecoration(labelText: "Enter book author"),
          ),
        ),

        Padding(
          padding: buttonInsets,
          child: ElevatedButton(
            onPressed: () { searchBookByNameNAuthor(); },
            child: Text("Search")
          ),
        )
      ],
    );
  }
  
  Widget getSearchChooserUI() {
    int i = 0;
    List<String> _searchOptions = ["Book ID", "Book name and author"];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Search using: "),
        DropdownButton(
          value: _dropdownValue,
          onChanged: this.setSearchType,
          items: _searchOptions.map<DropdownMenuItem<int>>((el) {
            return DropdownMenuItem<int>(
              value: i++,
              child: Text(el)
            );
          }).toList(),
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(title: Text("Search and Edit"),),
      body: ListView(
        children: [
          Container(
            child: getSearchChooserUI()
          ),

          Container(
            child: _searchInputUI,
          ),

          Padding(padding: EdgeInsets.only(top: 30)),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: AllBooks.getDataTableColumns(),
              rows: _dataTableRows,
            ),
          )
        ],
      ),
    );
  }
}