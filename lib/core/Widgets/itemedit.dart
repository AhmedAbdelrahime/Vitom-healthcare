import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class EditItem extends StatelessWidget {
  const EditItem({
    Key? key,
    this.controller,
    required this.label,
    required this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    required this.onChanged, // Define onChanged callback
  }) : super(key: key);

  final TextEditingController? controller;
  final String label;
  final Widget prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final ValueChanged<bool> onChanged; // Define onChanged callback

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        obscureText: obscureText,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(80)),
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon != null
              ? _PasswordVisibilityToggle(
                  obscureText: obscureText,
                  onTap: () {
                    // Toggle the obscureText value when the eye icon is tapped
                    onChanged(!obscureText);
                  },
                )
              : null,
        ),
        controller: controller,
      ),
    );
  }
}

class _PasswordVisibilityToggle extends StatelessWidget {
  final bool obscureText;
  final VoidCallback onTap;

  const _PasswordVisibilityToggle({
    Key? key,
    required this.obscureText,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: obscureText
          ? Icon(LineAwesomeIcons.eye_slash)
          : Icon(LineAwesomeIcons.eye),
      onPressed: onTap,
    );
  }
}
