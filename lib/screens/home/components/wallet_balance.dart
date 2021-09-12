import 'package:flutter/material.dart';
import '../../../constants.dart';

class WalletBalance extends StatelessWidget {
  const WalletBalance({
    Key? key,
    required this.balance,
    this.isShowed = true,
  }) : super(key: key);
  final String balance;
  final bool isShowed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          isShowed ? '\$ $balance' : '\$ *********',
          style: TextStyle(
            fontSize: 28,
            color: kWhiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Wallet balance',
          style: TextStyle(color: kWhiteColor.withOpacity(0.8)),
        ),
      ],
    );
  }
}
