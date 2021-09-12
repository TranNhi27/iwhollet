import 'package:flutter/material.dart';
import 'package:iwhollet/constants.dart';

import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String routeName = '/home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('ICON Wallet'),
        backgroundColor: kPrimaryColor,
        elevation: 0,

      ),
      backgroundColor: kPrimaryColor,
      body: Body(),
    );
  }
}
