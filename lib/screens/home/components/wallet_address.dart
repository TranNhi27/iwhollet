import 'package:flutter/material.dart';
import '../../../constants.dart';


class WalletAddress extends StatelessWidget {
  const WalletAddress({
    Key? key,
    required this.address,
  }) : super(key: key);

  final String address;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Address:',
            style: TextStyle(
                color: kWhiteColor, fontSize: 16, fontWeight: FontWeight.bold)),
        Flexible(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: k16Padding / 2),
            child: Text(address,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: kWhiteColor, fontSize: 16)),
          ),
        )
      ],
    );
  }
}
