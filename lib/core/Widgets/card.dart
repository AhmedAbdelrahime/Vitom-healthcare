import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String image;
  final String description;
  final VoidCallback onTap;

  const CustomCard({
    Key? key,
    required this.title,
    required this.image,
    required this.description,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isLargeScreen = constraints.maxWidth > 600;

        return GestureDetector(
          onTap: onTap,
          child: Container(
            width: isLargeScreen ? 350 : 300, // Increased width
            height: isLargeScreen ? 250 : 220, // Increased height
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 17.0,
                  color: Color(0x6B5ED2B7),
                  offset: Offset(0, 6),
                ),
              ],
              gradient: const LinearGradient(
                begin: Alignment(0.51, -0.86),
                end: Alignment(-0.51, 0.86),
                colors: [Color(0xFF5ED2D2), Color(0xFF5ED2B6)],
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: isLargeScreen ? 20.0 : 16.0, // Adjusted left position
                  top: isLargeScreen ? 160.0 : 128.0, // Adjusted top position
                  child: Container(
                    width: isLargeScreen ? 310.0 : 268.0, // Adjusted width
                    height: isLargeScreen ? 80 : 60, // Adjusted height
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: const Color(0xFFF5FAF9),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: isLargeScreen
                              ? 80.0
                              : 60.0, // Adjusted left position
                          top: isLargeScreen
                              ? 22.0
                              : 18.0, // Adjusted top position
                          child: Text(
                            title,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: isLargeScreen
                                  ? 20.0
                                  : 18.0, // Increased font size
                              fontFamily: 'Work Sans',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: isLargeScreen ? 90 : 80, // Adjusted left position
                  top: isLargeScreen ? -20.0 : -10.0, // Adjusted top position
                  child: Container(
                    width: isLargeScreen ? 170.0 : 150.0, // Increased width
                    height: isLargeScreen ? 170.0 : 150.0, // Increased height
                    decoration: ShapeDecoration(
                      color: Colors.white.withOpacity(0.3),
                      shape: const CircleBorder(),
                    ),
                    child: Center(
                      child: ClipOval(
                        child: Image.asset(
                          image,
                          width: 130, // Increased width
                          height: 110, // Increased height
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
