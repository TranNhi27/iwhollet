import 'package:flutter/material.dart';
import 'package:iwhollet/screens/create_wallet/create_wallet_screen.dart';
import 'package:iwhollet/screens/home/home_screen.dart';
import 'package:iwhollet/screens/welcome_screen/welcome_screen.dart';

final Map<String, WidgetBuilder> routes = {
  WelcomeScreen.routeName: (context) => WelcomeScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  CreateWalletScreen.routeName: (context) => CreateWalletScreen()
};