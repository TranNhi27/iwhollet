import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iwhollet/components/default_text_button.dart';
import 'package:iwhollet/constants.dart';
import 'package:iwhollet/screens/create_wallet/create_wallet_screen.dart';
import 'package:iwhollet/screens/home/home_screen.dart';
import 'package:iwhollet/size_config.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(flex: 2,),
            SvgPicture.asset('assets/images/logo.svg'),
            SizedBox(
              height: getProportionateScreenHeight(32),
            ),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: 'Welcome to\n',
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.white.withOpacity(0.3),
                    ),
                    children: [
                      TextSpan(
                          text: 'Whollet'.toUpperCase(),
                          style: TextStyle(fontSize: 48, color: Colors.white))
                    ])),
            Spacer(flex: 3,),
            DefaultTextButton(
              text: 'Sign In',
              press: () {
                // Navigator.pushNamed(context, HomeScreen.routeName);
              },
              textColor: kPrimaryColor,
              buttonColor: kWhiteColor,
            ),
            SizedBox(height: k16Padding,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don\'t have an account?',
                  style: TextStyle(color: kWhiteColor),
                ),
                SizedBox(width: 5,),
                GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, CreateWalletScreen.routeName);
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                          color: kWhiteColor, fontWeight: FontWeight.bold),
                    ))
              ],
            ),
            Spacer(flex: 1,),
          ],
        ),
      ),
    );
  }
}
