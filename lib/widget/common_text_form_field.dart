import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:texting_app/providers/text_field_provider.dart';
import 'package:texting_app/utils/constants.dart';

class CommonTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final String? Function(String?)? validator;
  final TextInputType? inputType;

  const CommonTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.isPassword,
    this.validator,
    this.inputType,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TextFieldProvider>(context);

    return SizedBox(
      height: mQHeight(41, context),
      width: mQWidth(274, context),
      child: TextFormField(
        controller: controller,
        style: TextStyle(
            color: isPassword
                ? (provider.isObscureText ? const Color(0xff898B8F) : themePurple)
                : themePurple),
        keyboardType: inputType ?? TextInputType.text,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.black),
          border: const OutlineInputBorder(borderSide: BorderSide()),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    provider.isObscureText
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: themeBlue,
                  ),
                  onPressed: () {
                    provider.toggleObscureText();
                  },
                )
              : null,
        ),
        obscureText: isPassword ? provider.isObscureText : false,
        validator: validator,
      ),
    );
  }
}
