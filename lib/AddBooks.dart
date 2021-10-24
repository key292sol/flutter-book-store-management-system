import 'package:book_store_management/data/AllBooks.dart';

void addMultiBooks() {
	List books = [
		{
			"name": "Java",
			"author": "ABC",
			"price": 200,
			"count": 50
		},
		{
			"name": "Python",
			"author": "ABC",
			"price": 200,
			"count": 30
		},
		{
			"name": "PHP",
			"author": "DEF",
			"price": 150,
			"count": 50
		},
		{
			"name": "JavaScript",
			"author": "DEF",
			"price": 220,
			"count": 45
		},
		{
			"name": "DSA",
			"author": "DEF",
			"price": 300,
			"count": 100
		},
	];

  // for (var i = 0; i < 10; i++) {
    for (var book in books) {
      AllBooks.addBook(book["name"], book["author"], book["price"], book["count"]);
    }
  // }
}