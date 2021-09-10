import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_icon_network/flutter_icon_network.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iwhollet/constants.dart';
import 'package:iwhollet/models/UserWallet.dart';
import 'package:iwhollet/size_config.dart';
import 'transfer_area_with_balance_box.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isShowed = true;
  @override
  Widget build(BuildContext context) {
    final UserWallet? userWallet = ModalRoute.of(context)!.settings.arguments as UserWallet?;
    
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Container(
              width: SizeConfig.screenWidth,
              padding: EdgeInsets.only(
                  top: k24Padding, left: k24Padding, right: k24Padding),
              height: SizeConfig.screenHeight! * 0.3,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: getProportionateScreenHeight(32),
                      width: getProportionateScreenWidth(32),
                      child: InkWell(
                          onTap: () => setState(() {
                                if (isShowed == false)
                                  isShowed = true;
                                else
                                  isShowed = false;
                              }),
                          child: SvgPicture.asset(
                            isShowed
                                ? 'assets/icons/hide.svg'
                                : 'assets/icons/unhide.svg',
                            color: kWhiteColor,
                          )),
                    ),
                  ),
                  WalletBalance(
                    balance: (userWallet!.balance * 1.819).toString(),
                    isShowed: isShowed,
                  ),
                  SizedBox(
                    height: k24Padding + k16Padding,
                  ),
                  WalletAddress(
                    address: userWallet.address,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: getProportionateScreenHeight(25),
                      width: getProportionateScreenWidth(25),
                      child: InkWell(
                          onTap: () => setState(() => print(userWallet.balance)),
                          child: SvgPicture.asset(
                            'assets/icons/copy.svg',
                            color: kWhiteColor,
                          )),
                    ),
                  ),
                ],
              ),
            ),
            TransferAreaWithBalanceBox(
              totalCoin: userWallet.balance.toString(),
              isShowed: isShowed,
            )
          ],
        ),
      ),
    );
  }
}

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
