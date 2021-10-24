import 'package:book_store_management/data/Book.dart';
import 'package:flutter/material.dart';

class MyTable {
	static List<DataColumn> getAsDataTableHeader(List<String> arr, {TextStyle? textStyling}) {
		textStyling = (textStyling != null) 
			? textStyling 
			: TextStyle(
				fontSize: 25,
				fontWeight: FontWeight.bold
			);

		return arr.map<DataColumn>((e) {
			return DataColumn(
				label: Text(
					e,
					style: textStyling,
				)
			);
		}).toList();
	}

	static List<DataRow> getBooksDataTableRows(List<Book> booksList, {TextStyle? textStyling}) {
		textStyling = (textStyling != null) 
			? textStyling 
			: TextStyle(
				fontSize: 20,
				fontWeight: FontWeight.normal
			);

		DataCell Function(String) getDataCell = (String val) {
			return DataCell(
				Text(
					val,
					style: textStyling,
				)
			);
		};

		int i = 0;

		return booksList.map<DataRow>((e) {
			Map bookValues = e.getAsMap();
			i++;

			return DataRow(cells: [
				getDataCell(i.toString()),
				getDataCell(bookValues["name"]),
				getDataCell(bookValues["author"]),
				getDataCell(bookValues["price"]),
				getDataCell(bookValues["count"]),
			]);
		}).toList();
	}
}