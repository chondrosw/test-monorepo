import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:test_zero_app/Utils/Style/Style.dart';

class ButtonPrimaryWidget extends StatelessWidget {
  final String title;
  final Color primaryColor;
  final Function() onPressed;
  const ButtonPrimaryWidget(
      {Key? key,
      required this.primaryColor,
      required this.title,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? ElevatedButton(
            onPressed: onPressed,
            child: Text(
              title,
              style: h4Title.copyWith(fontWeight: FontWeight.w500),
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              primary: primaryColor,
              padding: const EdgeInsets.all(10),
            ),
          )
        : CupertinoButton(
            child: Text(title,
                style: h4Title.copyWith(fontWeight: FontWeight.w500)),
            onPressed: onPressed,
            borderRadius: BorderRadius.circular(12),
            color: primaryColor,
          );
  }
}
