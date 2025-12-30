import 'dart:math';
import 'package:flutter/material.dart';
import 'package:helping_hand/games/game3/situationB2.dart';
import 'package:helping_hand/games/game4/situationC2.dart';

class SituationB1 extends StatelessWidget {
  const SituationB1({super.key});

  @override
  Widget build(BuildContext context) {
    final random = Random();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// 🔹 النص
            const Text(
              'واجهة تجريبية',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            /// 🔹 الخط الفاصل
            const Divider(thickness: 2),

            const SizedBox(height: 20),

            /// 🔹 الدوائر بدون تراكب
            Expanded(
              child: GridView.builder(
                itemCount: 12,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // عدد الأعمدة
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SituationB2(),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue
                            .withOpacity(0.5 + random.nextDouble() * 0.5),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
