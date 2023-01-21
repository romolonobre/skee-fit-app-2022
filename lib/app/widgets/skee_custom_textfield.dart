// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import '../core/skee_ui/skee_palette.dart';

class SkeeCustomTextfield extends StatefulWidget {
  final String? hintText;
  final TextInputType? keyboardType;
  final GlobalKey<FormFieldState>? formFieldKey;
  final bool isSecret;
  final IconData icon;
  bool? obscureText;
  String? Function(String?)? validator;
  final TextEditingController? controller;
  final Function(String)? onChanged;

  SkeeCustomTextfield({
    Key? key,
    this.keyboardType,
    this.formFieldKey,
    this.isSecret = false,
    this.hintText,
    required this.icon,
    this.obscureText = false,
    this.controller,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  State<SkeeCustomTextfield> createState() => _SkeeCustomTextfieldState();
}

class _SkeeCustomTextfieldState extends State<SkeeCustomTextfield> {
  bool isObscure = false;

  @override
  void initState() {
    super.initState();

    isObscure = widget.isSecret;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 45,
          child: TextFormField(
            keyboardType: widget.keyboardType,
            key: widget.formFieldKey,
            obscureText: isObscure,
            controller: widget.controller,
            validator: widget.validator,
            onChanged: widget.onChanged,
            style: const TextStyle(color: SkeePalette.primaryColor),
            decoration: InputDecoration(
              suffixIcon: widget.isSecret
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                      icon: Icon(isObscure ? Icons.visibility_off : Icons.visibility),
                    )
                  : null,
              hintText: widget.hintText,
              hintStyle: const TextStyle(color: SkeePalette.primaryColor, fontSize: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: SkeePalette.primaryColor, width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: const BorderSide(
                  color: SkeePalette.primaryColor,
                  width: 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
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
