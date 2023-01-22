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
  final Function? ontap;

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
  State<SkeeCustomTextfield> createState() => _SkeeCustomTextfieldState();
}

class _SkeeCustomTextfieldState extends State<SkeeCustomTextfield> {
  @override
  void initState() {
    super.initState();
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
            controller: widget.controller,
            validator: widget.validator,
            onChanged: widget.onChanged,
            style: const TextStyle(color: SkeePalette.primaryColor),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: const Icon(Icons.search, color: Colors.white),
                onPressed: widget.ontap != null ? () => widget.ontap!() : null,
              ),
              hintText: widget.hintText,
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
