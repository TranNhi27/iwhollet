import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icon_network/flutter_icon_network.dart';
import 'package:iwhollet/models/UserWallet.dart';
import 'package:iwhollet/screens/home/home_screen.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final UserWallet userWallet = UserWallet();
  final privateKeyCtrl = TextEditingController();
  final walletAddressCtrl = TextEditingController();

  //send icx
  final icxSenderCtrl = TextEditingController();
  final icxReceiverCtrl = TextEditingController();
  final icxSendAmountCtrl = TextEditingController();

  Future<void> _createWallet() async {
    final wallet = await FlutterIconNetwork.instance!.createWallet;
    setState(() {
      userWallet.address = wallet.address!;
      userWallet.privateKey = wallet.privateKey!;
      print(userWallet);
      _btnController.reset();
    });
  }

  Future<void> _getIcxBalance() async {
    final balance = await FlutterIconNetwork.instance!
        .getIcxBalance(privateKey: userWallet.privateKey);
    setState(() {
      userWallet.balance = balance.icxBalance;
      print(userWallet.balance);
      _btnController.reset();
    });
  }

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  Future<void> _getWalletByPrivateKey() async {
    try {final wallet = await FlutterIconNetwork.instance!
        .getWalletByPrivateKey(privateKeyCtrl.text);
    if (wallet == null) return;
    setState(() {
      userWallet.address = wallet['address'] as String;
      userWallet.privateKey = wallet['private_key'] as String;
      print(userWallet.address);
    });}
    on PlatformException catch(_) {
      _btnController.error();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Image.asset('assets/images/desktop.png'),
            Expanded(
                child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                  vertical: k24Padding, horizontal: k24Padding * 2),
              decoration: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 5), color: kDarkGray, blurRadius: 10)
                  ]),
              child: Column(
                children: [
                  Text(
                    'Welcome to\nWhollet',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Manage all your crypto assets! It’s simple and easy!',
                    textAlign: TextAlign.center,
                  ),
                  Spacer(
                    flex: 4,
                  ),
                  RoundedLoadingButton(
                      controller: _btnController,
                      onPressed: () async {
                        await _createWallet();
                        Navigator.popAndPushNamed(context, HomeScreen.routeName,
                            arguments: userWallet);
                      },
                      child: Text(
                        'Create Wallet',
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have a wallet?',
                        style: TextStyle(),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                          onTap: () => showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    title: Text('Enter your private key: '),
                                    content: Container(
                                      height: getProportionateScreenHeight(100),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border:
                                              Border.all(color: kGrayColor)),
                                      child: TextFormField(
                                        controller: privateKeyCtrl,
                                        maxLines: 4,
                                      ),
                                    ),
                                    actions: [
                                      RoundedLoadingButton(
                                        width: getProportionateScreenWidth(100),
                                          controller: _btnController,
                                          onPressed: () async {
                                            await _getWalletByPrivateKey();
                                            await _getIcxBalance();
                                            Navigator.popAndPushNamed(
                                                context, HomeScreen.routeName,
                                                arguments: userWallet);
                                          },
                                          child: Text('OK'))
                                    ],
                                  )),
                          child: Text(
                            'Load wallet',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                  Spacer(
                    flex: 2,
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
