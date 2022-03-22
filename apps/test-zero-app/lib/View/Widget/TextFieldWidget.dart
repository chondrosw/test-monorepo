import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:test_zero_app/Utils/Style/Style.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String placeHolder;
  bool obsecureText = false;
  final Function() onChangeSecure;
  final String? Function(String?)? validator;
  final bool isPassword;

  TextFieldWidget(
      {Key? key,
      required this.controller,
      required this.title,
      required this.obsecureText,
      required this.placeHolder,
      required this.validator,
      required this.isPassword, required this.onChangeSecure})
      : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: h4Title.copyWith(),
        ),
        Platform.isAndroid
            ? TextFormField(
                style:
                    h5Title.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                controller: controller,
                obscureText: obsecureText,
                decoration: InputDecoration(
                    hintText: placeHolder,
                    filled: true,
                    fillColor: textFieldFill,
                    suffixIcon: isPassword
                        ? IconButton(
                            onPressed: onChangeSecure,
                            icon: Icon(
                              obsecureText
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility,
                              color: Colors.black,
                            ))
                        : null,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8))),
                validator: validator,
              )
            : Container(
                height: 52,
                padding: EdgeInsets.only(top: 4),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black)),
                child: Center(
                  child: Row(
                    children: [
                      Expanded(child: CupertinoTextFormFieldRow(
                        controller: controller,
                        obscureText: obsecureText,
                        placeholder: placeHolder,
                        decoration: const BoxDecoration(color: Colors.white),
                      ),),

                      isPassword
                          ? IconButton(
                              onPressed: onChangeSecure,
                              icon: Icon(
                                obsecureText
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility,
                                color: Colors.black,
                              ))
                          : SizedBox(
                              width: 20,
                            )
                    ],
                  ),
                ),
              )
      ],
    );
  }
}
