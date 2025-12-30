import 'package:flutter/material.dart';

class SituationB3 extends StatelessWidget {
  const SituationB3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            /// ⏳ إيحاء الوقت
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.hourglass_top, color: Colors.grey),
                SizedBox(width: 6),
                Text(
                  'الوقت ما زال جاريًا...',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// 🌺 الوردة + النص
            Stack(
              alignment: Alignment.center,
              children: [

                CustomPaint(
                  size: const Size(260, 260),
                  painter: FlowerPainter(),
                ),

                const Padding(
                  padding: EdgeInsets.all(35),
                  child: Text(
                    'لا تضغطي على الشاشة\nحتى ينتهي الوقت المحدد ⏳',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            /// 🖼️ صورة الساعة (إيحاء بصري)
            Image.asset(
              'assets/hourglass.png',
              width: 80,
              height: 80,
            ),
          ],
        ),
      ),
    );
  }
}
class FlowerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.pinkAccent
      ..style = PaintingStyle.fill;

    final path = Path();
    final cx = size.width / 2;
    final cy = size.height / 2;

    path.moveTo(cx, cy - 80);

    path.quadraticBezierTo(size.width, 0, cx + 80, cy);
    path.quadraticBezierTo(size.width, size.height, cx, cy + 80);
    path.quadraticBezierTo(0, size.height, cx - 80, cy);
    path.quadraticBezierTo(0, 0, cx, cy - 80);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
