import 'package:flutter/material.dart';
import 'package:book_store_management/globals.dart';

class ShowDialogs {
	static void showToast([String text = "SnackBar"]) {
		final SnackBar snackBar = SnackBar(content: Text(text));
		snackbarKey.currentState?.showSnackBar(snackBar);
	}

	static void alertUser({required BuildContext context, String titleText = "Alert message", String contentText = "Content"}) {
		AlertDialog alertd = AlertDialog(
			title: Text(titleText),
			content: Text(contentText),
			actions: [
				TextButton(
					onPressed: () => Navigator.of(context).pop(), 
					child: Text("Close")
				)
			],
		);

		showDialog(
			context: context, 
			builder: (BuildContext context) => alertd
		);
	}
}
