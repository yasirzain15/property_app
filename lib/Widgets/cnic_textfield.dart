import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rent_pay/Core/Constants/colors.dart';

class CnicTextField extends StatefulWidget {
  final TextEditingController controller;

  const CnicTextField({super.key, required this.controller});

  @override
  State<CnicTextField> createState() => _CnicTextFieldState();
}

class _CnicTextFieldState extends State<CnicTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: TextInputType.number,
      maxLength: 16,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        CnicInputFormatter(), // auto dash formatter
      ],
      decoration: InputDecoration(
        counterText: "",
        hintText: "31302-67045435-0",
        prefixIcon: const Icon(Icons.credit_card, color: AppColors.primary),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
      ),
    );
  }
}

/// Custom input formatter for CNIC
class CnicInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String digitsOnly = newValue.text.replaceAll('-', '');
    if (digitsOnly.length > 14) digitsOnly = digitsOnly.substring(0, 14);

    String formatted = '';
    for (int i = 0; i < digitsOnly.length; i++) {
      if (i == 5 || i == 13) formatted += '-';
      formatted += digitsOnly[i];
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
