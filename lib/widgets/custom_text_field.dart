import 'package:flutter/material.dart';
import '../helpers/styles.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool? isObscureText;
  final GestureTapCallback? onVisibilityToggled;
  final IconData prefixIcon;
  const CustomTextField({
    Key? key,
    this.isObscureText,
    this.onVisibilityToggled,
    required this.prefixIcon,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10.0)),
      child: TextField(
        controller: controller,
        obscureText: isObscureText ?? false,
        decoration: InputDecoration(
            border: InputBorder.none,
            suffixIcon: isObscureText != null
                ? IconButton(
                    splashColor: Colors.transparent,
                    onPressed: onVisibilityToggled,
                    icon: Icon(
                        isObscureText!
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Styles.primaryColor))
                : const SizedBox.shrink(),
            prefixIcon: Icon(
              prefixIcon,
              color: Styles.primaryColor,
            )),
      ),
    );
  }
}
