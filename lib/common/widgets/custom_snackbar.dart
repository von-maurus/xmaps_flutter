import 'package:flutter/material.dart';

class CustomSnackbar extends SnackBar {
  CustomSnackbar({
    super.key,
    required String content,
    super.duration = const Duration(seconds: 3),
    Color super.backgroundColor = Colors.black,
    void Function()? onPressed,
    String btnLabel = "Ok",
    super.showCloseIcon = false,
  }) : super(
          content: Text(content),
          action: SnackBarAction(
            label: btnLabel,
            onPressed: onPressed ?? () {},
          ),
        );
}
