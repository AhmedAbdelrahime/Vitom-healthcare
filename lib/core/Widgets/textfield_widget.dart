import 'package:flutter/material.dart';
import 'package:complex_ui_rive_animation/core/constans.dart';

// class TextFieldWidget extends StatefulWidget {
//   final int maxLines;
//   final String label;
//   final String text;
//   final ValueChanged<String> onChanged;

//   const TextFieldWidget({
//     Key? key,
//     this.maxLines = 1,
//     required this.label,
//     required this.text,
//     required this.onChanged,
//   }) : super(key: key);

//   @override
//   _TextFieldWidgetState createState() => _TextFieldWidgetState();
// }

// class _TextFieldWidgetState extends State<TextFieldWidget> {
//   late final TextEditingController controller = TextEditingController(
//       text: widget.text); // Initialize the TextEditingController

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     controller.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) => Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             widget.label,
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//           ),
//           const SizedBox(height: 8),
//           TextField(
//             controller: controller,
//             decoration: InputDecoration(
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//             maxLines: widget.maxLines,
//           ),
//         ],
//       );
// }

class Textfield extends StatefulWidget {
  const Textfield(
      {super.key,
      required this.label,
      required this.onChanged,
      required this.controller});
  final String label;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;

  @override
  State<Textfield> createState() => _TextfieldState();
}

class _TextfieldState extends State<Textfield> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),

        TextField(
          controller: widget.controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            fillColor: KMainColor.withOpacity(0.1),
            filled: true,
            //  prefixIcon: ,
            contentPadding: EdgeInsets.symmetric(vertical: 16),
          ),
          //  onChanged: (value) {},
        ),
        // const SizedBox(height: 24),
        // Text('Username: $username'),
      ],
    );
  }
}

class FormQustion extends StatefulWidget {
  const FormQustion({super.key, required this.label, required this.controller});
  final String label;
  //final ValueChanged<String> onChanged;
  final TextEditingController controller;
  @override
  State<FormQustion> createState() => _FormQustionState();
}

class _FormQustionState extends State<FormQustion> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(width: 12),
          TextField(
            keyboardType: TextInputType.number,
            // obscureText: obscureText,
            decoration: InputDecoration(
              //  hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              fillColor: KMainColor.withOpacity(0.1),
              filled: true,
              // prefixIcon: suffixIcon,
              contentPadding: EdgeInsets.symmetric(vertical: 16),
            ),
            controller: widget.controller,
          ),
        ],
      ),
    );
  }
}
