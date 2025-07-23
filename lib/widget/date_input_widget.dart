import 'package:flutter/material.dart';

class DateInputWidget extends StatefulWidget {
  final TextEditingController controller;
  final String? label;
  final Widget suffixIcon;
  final String? Function(String?)? validator;

  const DateInputWidget({
    super.key,
    required this.controller,
    this.label,
    required this.suffixIcon,
    this.validator,
  });

  @override
  _DateInputWidgetState createState() => _DateInputWidgetState();
}

class _DateInputWidgetState extends State<DateInputWidget> {
  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        widget.controller.text =
            "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      readOnly: true,
      decoration: InputDecoration(
        suffixIcon: widget.suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      ),
      onTap: () => _selectDate(context),
      validator: widget.validator,
    );
  }
}
