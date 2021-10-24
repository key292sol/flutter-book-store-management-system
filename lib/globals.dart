import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> snackbarKey = GlobalKey<ScaffoldMessengerState>();
final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

void navigateToScreen(Widget toScreen) {
	var mpr = MaterialPageRoute(builder: (BuildContext buildContext) => toScreen);
	// Navigator.of(context).push(mpr);
  navigatorKey.currentState!.push(mpr);
}

void navigatePop() {
  navigatorKey.currentState!.pop();
}