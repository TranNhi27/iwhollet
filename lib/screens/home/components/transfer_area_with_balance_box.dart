import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';


class TransferAreaWithBalanceBox extends StatelessWidget {
  const TransferAreaWithBalanceBox({
    Key? key, required this.totalCoin, this.isShowed = true,
  }) : super(key: key);
  final String totalCoin;
  final bool isShowed;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: SizeConfig.screenHeight! * 0.6 - 40,
                decoration: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30)
                    )
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
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(5,5),
                          color: kDarkGray,
                          blurRadius: 5
                      )
                    ]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(isShowed ? totalCoin : '*******', style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w700
                    ),),

                    Text('ICX', style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                    ),),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}