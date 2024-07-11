import 'package:flutter/material.dart';

class VitalSignCard extends StatelessWidget {
  const VitalSignCard({
    Key? key,
    required this.title,
    required this.value,
    required this.status,
    required this.iconData,
  }) : super(key: key);

  final String title;
  final String value;
  final String status;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(width: 1, color: const Color(0xFFE7E6E6)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 50,
            offset: Offset(0, 1),
            spreadRadius: 0,
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            iconData,
            color: Colors.black,
            size: 24,
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: 'Mulish',
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '$value ${_getUnit(title)}',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Mulish',
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Status: $status',
            style: TextStyle(
              fontSize: 12,
              color: status == 'Normal' ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  String _getUnit(String title) {
    switch (title) {
      case 'Heart Rate':
        return 'bpm';
      case 'Temperature':
        return '°C';
      case 'Oxygen Level':
        return '%';
      default:
        return '';
    }
  }
}
