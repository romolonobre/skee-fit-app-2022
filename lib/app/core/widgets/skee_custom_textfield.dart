// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import '../skee_ui/skee_palette.dart';

class SkeeCustomTextfield extends StatelessWidget {
  final String? hintText;
  final TextInputType? keyboardType;
  final GlobalKey<FormFieldState>? formFieldKey;
  final bool isSecret;
  final IconData icon;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function? ontap;
  bool? obscureText;
  String? Function(String?)? validator;

  SkeeCustomTextfield({
    Key? key,
    this.hintText,
    this.keyboardType,
    this.formFieldKey,
    this.isSecret = false,
    required this.icon,
    this.obscureText = false,
    this.validator,
    this.controller,
    this.onChanged,
    this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 45,
          child: TextFormField(
            keyboardType: keyboardType,
            key: formFieldKey,
            controller: controller,
            validator: validator,
            onChanged: onChanged,
            style: const TextStyle(color: SkeePalette.primaryColor),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: const Icon(Icons.search, color: Colors.white),
                onPressed: ontap != null ? () => ontap!() : null,
              ),
              hintText: hintText,
              hintStyle: const TextStyle(color: SkeePalette.primaryColor, fontSize: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: SkeePalette.primaryColor, width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: SkeePalette.primaryColor,
                  width: 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: SkeePalette.primaryColor,
                  width: 1.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
