import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icon_network/flutter_icon_network.dart';
import 'package:intl/intl.dart';
import 'package:iwhollet/components/default_text_button.dart';
import 'package:iwhollet/models/UserWallet.dart';
import 'package:iwhollet/screens/home/components/copy_icon.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class TransferAreaWithBalanceBox extends StatefulWidget {
  const TransferAreaWithBalanceBox({
    Key? key,

    this.isShowed = true,
    required this.userWallet,
  }) : super(key: key);

  final bool isShowed;
  final UserWallet userWallet;

  @override
  State<TransferAreaWithBalanceBox> createState() =>
      _TransferAreaWithBalanceBoxState();
}

class _TransferAreaWithBalanceBoxState
    extends State<TransferAreaWithBalanceBox> {
  String txHash = "";
  final icxReceiverCtrl = TextEditingController();
  final icxSendAmountCtrl = TextEditingController();
  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();
  int status = 1;

  Future<void> _getIcxBalance() async {
      final balance = await FlutterIconNetwork.instance!
          .getIcxBalance(privateKey: widget.userWallet.privateKey);
      setState(() {
        widget.userWallet.balance = balance.icxBalance;
      });

  }

  Future<void> _sendIcx() async {
    try {
    final response = await FlutterIconNetwork.instance!.sendIcx(
        yourPrivateKey: widget.userWallet.privateKey,
        destinationAddress: icxReceiverCtrl.text,
        value: icxSendAmountCtrl.text);
    Clipboard.setData(ClipboardData(text: response.txHash));
    setState(() {
      txHash = "${response.txHash}";
      status = response.status as int;
    });
    Future.delayed(const Duration(milliseconds: 4000), () async {
      await _getIcxBalance();
    });}
    on PlatformException catch (_) {
      txHash = '';
      status = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
    return SizedBox(
      height: SizeConfig.screenHeight! * 0.7,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: SizeConfig.screenHeight! * 0.7 - 30,
              padding: EdgeInsets.only(
                  top: k24Padding * 2 + k16Padding,
                  right: k24Padding,
                  left: k24Padding),
              decoration: const BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  TextFormField(
                    controller: icxReceiverCtrl,
                    decoration: const InputDecoration(
                        labelText: 'Address', hintText: 'Enter address'),
                  ),
                  TextFormField(
                    controller: icxSendAmountCtrl,
                    decoration: const InputDecoration(
                        labelText: 'Amount', hintText: 'Enter ICX amount'),
                  ),
                  SizedBox(
                    height: k24Padding,
                  ),
                  RoundedLoadingButton(
                      controller: _btnController,
                      onPressed: () async {
                        await _sendIcx();
                        buildTransactionAlert(context: context, dateTime: formattedDate);
                        _btnController.reset();
                      },
                      child: const Text('Transfer'))
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: k24Padding),
              height: getProportionateScreenHeight(80),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: kWhiteColor,
                  boxShadow: const [
                    BoxShadow(
                        offset: Offset(5, 5), color: kDarkGray, blurRadius: 5)
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    widget.isShowed ? '${widget.userWallet.balance}' : '*******',
                    style: const TextStyle(
                        color: kPrimaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  const Text(
                    'ICX',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

 buildTransactionAlert({required BuildContext context, required String dateTime}) {
     AlertDialog alert =AlertDialog(
          title: const Text('Transaction Details:'),
          titleTextStyle: const TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold, fontSize: 20),
          content: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text('Amount:'),
                  Text(
                    '${icxSendAmountCtrl.text} ICX',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(status == 0 ? 'Successful!' : 'Fail! Unvalid address',
                    style: const TextStyle(color: kPrimaryColor, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(dateTime),
                  buildTransactionTitleAndContent(title: 'Txhash: ',content: txHash),
                  buildTransactionTitleAndContent(title: 'From Address: ',content: widget.userWallet.address),
                  buildTransactionTitleAndContent(title: 'To Address: ',content: icxReceiverCtrl.text),
                  SizedBox(height: k24Padding,),
                  DefaultTextButton(
                    text: 'Check TxHash',press: () {
                    launch("https://bicon.tracker.solidwallet.io/transaction/$txHash");
                  }, )
                ],
              ),
            ),
          ),
        );
     showDialog(
       context: context,
       builder: (BuildContext context) {
         return alert;
       },
     );
  }

  Padding buildTransactionTitleAndContent({required String title, required String content}) {
    return Padding(
      padding:
          EdgeInsets.only(top: k16Padding/2, left: k16Padding/2, right: k16Padding/2),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$title \n',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              CopyIcon(copyContent: content)
            ],
          ),
          Text(content),
        ],
      ),
    );
  }
}
