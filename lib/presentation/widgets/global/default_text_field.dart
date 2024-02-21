import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/colors.dart';

class DefaultTextField extends StatefulWidget {
  TextEditingController control;
  TextInputType type;
  String text;
  bool readOnly;
  bool isPassword;
  ValueChanged? onSubmit;
  ValueChanged? onchange;
  GestureTapCallback? onTape;
  FormFieldValidator? validate;
  Color iconColor;
  int? maxLines;

  DefaultTextField({
    super.key,
    required this.control,
    required this.type,
    required this.text,
    this.readOnly = false,
    this.onSubmit,
    this.onchange,
    this.onTape,
    this.validate,
    this.iconColor = Colors.black,
    this.maxLines = 1,
    this.isPassword = false,
  });

  @override
  State<DefaultTextField> createState() => _DefaultTextFieldState();
}

class _DefaultTextFieldState extends State<DefaultTextField> {
  bool obscure = true;

  IconData suffixIcon = Icons.visibility_outlined;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: widget.readOnly,
      controller: widget.control,
      keyboardType: widget.type,
      obscureText: widget.isPassword && obscure,
      onChanged: widget.onchange,
      onTap: widget.onTape,
      validator: widget.validate,
      maxLines: widget.maxLines,
      onFieldSubmitted: widget.onSubmit,
      cursorColor: Colors.black,
      style: GoogleFonts.roboto(fontSize: 12, color: Colors.black),
      decoration: InputDecoration(
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  suffixIcon,
                  color: ConstColors.primaryColor,
                ),
                onPressed: () {
                  setState(() {
                    suffixIcon = obscure
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined;
                    obscure = !obscure;
                  });
                },
              )
            : const SizedBox(),
        contentPadding:
            const EdgeInsets.only(top: 10, bottom: 0, left: 10, right: 10),
        labelText: widget.text,
        labelStyle: GoogleFonts.roboto(
            fontSize: 10, color: Colors.black, fontWeight: FontWeight.w500),
        focusedBorder: OutlineInputBorder(
          gapPadding: 1.0,
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(
            color: ConstColors.primaryColor,
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(
            color: ConstColors.primaryColor,
            width: 1.0,
          ),
        ),
        errorStyle: const TextStyle(
          fontSize: 10,
          color: ConstColors.primaryColor,
        ),
      ),
    );
  }
}
