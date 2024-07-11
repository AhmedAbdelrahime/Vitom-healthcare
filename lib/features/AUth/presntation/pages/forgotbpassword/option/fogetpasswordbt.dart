import 'package:flutter/material.dart';

class ForgetPasswordBtnWidget extends StatelessWidget {
  const ForgetPasswordBtnWidget({
    required this.btnIcon,
    required this.title,
    required this.subTitle,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final IconData btnIcon;
  final String title, subTitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final double scaleFactor =
        MediaQuery.of(context).size.width > 600 ? 1.0 : 0.8;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 20.0 * scaleFactor,
          horizontal: 10.0 * scaleFactor,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0 * scaleFactor),
          color: Colors.grey.shade200,
        ),
        child: Row(
          children: [
            Icon(btnIcon,
                size: 60.0 * scaleFactor), // Use Line Awesome icon here
            SizedBox(width: 10.0 * scaleFactor),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 20.0 * scaleFactor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(height: 5.0 * scaleFactor),
                  Text(
                    subTitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 16.0 * scaleFactor,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
