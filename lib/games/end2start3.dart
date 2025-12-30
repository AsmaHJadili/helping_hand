import 'package:flutter/material.dart';
import 'package:helping_hand/games/end3start4.dart';
import 'package:helping_hand/games/game3/situationB1.dart';

import 'game1/situation1.dart';

class End2Start3 extends StatefulWidget {
  @override
  _End2Start3State createState() => _End2Start3State();
}

class _End2Start3State extends State<End2Start3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // لون الخلفية الرمادي الداكن الذي يظهر خلف البطاقة
      // backgroundColor: const Color(0xFF4A4A4A),

      body: Center(
        child: Container(
          // تصميم البطاقة الفيروزية
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF4DB6AC), // اللون الفيروزي من الصورة
            borderRadius: BorderRadius.circular(40), // حواف مستديرة كبيرة
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                // blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),

              // نص "لعبة رقم 1"
              const Text(
                'ممتاز أيها البطل ! \n  الان انتقل الى اللعبة التالية',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),

              // نص "رحلة المشاعر"
              const Text(
                'صندوق الكنز \n الايجابي',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const Spacer(flex: 3),

              // زر "هيا نبدأ !"
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SituationB1(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0F2E33), // الكحلي الداكن من الصورة
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      'هيا نبدأ !',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}