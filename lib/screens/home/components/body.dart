import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iwhollet/constants.dart';
import 'package:iwhollet/models/UserWallet.dart';
import 'package:iwhollet/size_config.dart';
import 'copy_icon.dart';
import 'transfer_area_with_balance_box.dart';
import 'wallet_address.dart';
import 'wallet_balance.dart';

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
      child: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          height: SizeConfig.screenHeight,
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            children: [
              Container(
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
                      child: CopyIcon(copyContent: userWallet.address,
                        color: kWhiteColor,
                      ),
                    ),
                  ],
                ),
              ),
              TransferAreaWithBalanceBox(
                isShowed: isShowed,
                userWallet: userWallet,
              )
            ],
          ),
        ),
      ),
    );
  }
}



