import 'package:book_store_management/data/Book.dart';
import 'package:book_store_management/ui/custom_widgets/MyTable.dart';
import 'package:flutter/material.dart';

class AllBooks {
	static List<Book> _allBooks = [];
  static int _lastId = 0;

  static Book? getBookById(int bookId) {
    if (bookId < getFirstBookId() && bookId >= getLastBookId()) {
      return null;
    }

    for (Book book in _allBooks) {
      if (book.id == bookId) {
        return book;
      }
    }

    return null;
  }

  static List<Book> getAllBooksCopy([bool growable = false]) {
    return List.from(_allBooks, growable: growable);
  }

  static int getAllBooksLength() {
    return _allBooks.length;
  }

  static int getFirstBookId() {
    int id = (_allBooks.length > 0) ? _allBooks[0].id : -1;
    return id;
  }

  static int getLastBookId() {
    int lastIndex = _allBooks.length - 1;
    int id = (_allBooks.length > 0) ? _allBooks[lastIndex].id : -1;
    return id;
  }

	static bool addBook(String bookName, String author, int price, int count) {
    _lastId++;
    int number = _lastId;
		Book b = new Book(number, bookName, author, price, count);
		return addBookByBook(b);
	}

  static bool doesBookNameNAuthorExist(String bookName, String bookAuthor) {
    for (var book in _allBooks) {
      if (book.name == bookName && book.author == bookAuthor) {
        return true;
      }
    }
    return false;
  }

	static bool addBookByBook(Book b) {
		if (doesBookNameNAuthorExist(b.name, b.author)) {
			return false;
		}
		_allBooks.add(b);
		return true;
	}

  static bool deleteBookById(int bookId) {
    if (bookId >= getFirstBookId() && bookId < getLastBookId()) {
      for(int i = 0; i < _allBooks.length; i++) {
        if (_allBooks[i].id == bookId) {
          _allBooks.removeAt(i);
          return true;
        }
      }
    }
    return false;
  }

	static bool deleteBookByNameNAuthor(String bookName, String bookAuthor) {
		for (var i = 0; i < _allBooks.length; i++) {
			Book book = _allBooks[i];

			if (book.name == bookName && book.author == bookAuthor) {
        _allBooks.removeAt(i);
        return true;
			}
		}

		return false;
	}

  static List<Book> getSearchedBooks({String bookName = "", String author = ""}) {
    List<Book> s = _allBooks.where((element) {
      return  (element.name.contains(bookName) && element.author.contains(author));
    }).toList();

    return s;
  }


	static List<DataRow> getAllBooksAsDataTableRows() {
		return MyTable.getBooksDataTableRows(_allBooks);
	}

  static List<DataColumn> getDataTableColumns({TextStyle? textStyling}) {
    List<String> cols = Book.getColumnNames();

    return MyTable.getAsDataTableHeader(cols, textStyling: textStyling);
  }

  static List<DataRow> getOneBookAsDataRows(int bookId) {
    for (var i = 0; i < _allBooks.length; i++) {
      if (_allBooks[i].id == bookId) {
        return MyTable.getBooksDataTableRows([_allBooks[i]]);
      }
    }

    return [];
  }

  static List<DataRow> getSearchBookAsDataRows({String bookName = "", String author = ""}) {
    List<Book> srchdBooks = getSearchedBooks(bookName: bookName, author: author);
    return MyTable.getBooksDataTableRows(srchdBooks);
  }

}