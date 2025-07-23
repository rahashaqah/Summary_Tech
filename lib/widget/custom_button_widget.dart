import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final void Function() onPress;
  final double? width;
  final double height;
  final String title;
  final double? borderRadius;
  final double? fontSize;
  final Color? textColor;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final double? padding;
  final TextAlign? textAlign;

  const CustomButton({
    Key? key,
    required this.onPress,
    this.width,
    required this.height,
    required this.title,
    this.borderRadius,
    this.fontSize,
    this.textColor,
    this.fontWeight,
    this.fontFamily,
    this.padding,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPress,
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 30),
      ),
      child: Container(
        width: width,
        height: height,
        padding: EdgeInsets.symmetric(horizontal: padding ?? 0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.deepPurple,
              Colors.purpleAccent,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(borderRadius ?? 30),
          boxShadow: [
            BoxShadow(
              color: Colors.deepPurple.withOpacity(0.3),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            textAlign: textAlign ?? TextAlign.center,
            style: TextStyle(
              color: textColor ?? Colors.white,
              fontSize: fontSize ?? 16,
              fontWeight: fontWeight ?? FontWeight.bold,
              fontFamily: fontFamily,
            ),
          ),
        ),
      ),
    );
  }
}
