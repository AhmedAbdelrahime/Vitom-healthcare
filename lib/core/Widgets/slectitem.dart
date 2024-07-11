import 'package:flutter/material.dart';

class SelctItem extends StatefulWidget {
  const SelctItem({
    Key? key,
    required this.text,
    required this.item1,
    required this.item2,
    required this.onChanged,
    required this.groupValue,
    this.item3,
    this.item4,
  }) : super(key: key);

  final String text;
  final String item1;
  final String item2;
  final String? item3;
  final String? item4;
  final ValueChanged<String?> onChanged;
  final String? groupValue;

  @override
  _SelctItemState createState() => _SelctItemState();
}

class _SelctItemState extends State<SelctItem> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.groupValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.text + ':',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 20),
          Row(
            children: [
              _buildRadio(widget.item1),
              Text(widget.item1,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  )),
              const SizedBox(width: 20),
              _buildRadio(widget.item2),
              Text(widget.item2),
              if (widget.item3 != null) ...[
                const SizedBox(width: 20),
                _buildRadio(widget.item3!),
                Text(widget.item3!),
              ],
              if (widget.item4 != null) ...[
                const SizedBox(width: 20),
                _buildRadio(widget.item4!),
                Text(widget.item4!),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRadio(String item) {
    return Radio(
      value: item,
      groupValue: _selectedValue,
      onChanged: (value) {
        setState(() {
          _selectedValue = value as String?;
        });
        widget.onChanged(value as String?);
      },
    );
  }
}
