import 'package:flutter/material.dart';

class InputWidget extends StatefulWidget {
  final TextEditingController textEditingController;
  final String? label;
  final bool isPassword;
  final String? errorText;
  final String? hintText;
  final Widget? prefixIcon;
  final int? maxLines;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  InputWidget({
    super.key,
    required this.textEditingController,
    this.label,
    this.isPassword = false,
    this.prefixIcon,
    this.maxLines,
    this.keyboardType,
    this.hintText,
    this.errorText,
    this.validator,
  });

  @override
  _InputWidgetState createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  bool _obscureText = true;
  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _obscureText,
      controller: widget.textEditingController,
      keyboardType: widget.keyboardType ?? TextInputType.text,
      maxLines: widget.maxLines ?? 1,
      validator: widget.validator,
      decoration: InputDecoration(
        labelText: widget.label,
        prefixIcon: widget.prefixIcon,
        hintText: widget.hintText,
        errorText: widget.errorText,
        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red[900]!, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red[900]!, width: 1),
        ),

        suffixIcon: widget.isPassword
            ? IconButton(
          icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        )
            : null,
      ),
    );
  }
}
