import 'package:flutter/material.dart';
import 'package:iwhollet/constants.dart';
import '../../size_config.dart';
import 'components/body.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static String routeName = '/welcome';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Body(),
    );
  }
}
