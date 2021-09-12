import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class CopyIcon extends StatefulWidget {
  const CopyIcon({
    Key? key, required this.copyContent, this.color = kGrayColor,
  }) : super(key: key);
  final String copyContent;
  final Color color;
  @override
  State<CopyIcon> createState() => _CopyIconState();
}

class _CopyIconState extends State<CopyIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(25),
      width: getProportionateScreenWidth(25),
      child: InkWell(
          onTap: () => setState(() {
            Clipboard.setData(new ClipboardData(text: widget.copyContent));
            final snackBar = SnackBar(
              content: const Text('Address copied'),);
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }),
          child: SvgPicture.asset(
            'assets/icons/copy.svg',
            color: widget.color,
          )),
    );
  }
}