import 'package:flutter/material.dart';
import 'components/body.dart';

class CreateWalletScreen extends StatelessWidget {
  const CreateWalletScreen({Key? key}) : super(key: key);
  static String routeName = '/createWallet';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallet'),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: Body(),
    );
  }
}
