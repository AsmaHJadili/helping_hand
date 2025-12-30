
import 'package:flutter/material.dart';
import 'package:helping_hand/games/game3/situationB3.dart';
class SituationB2 extends StatefulWidget {
  const SituationB2({super.key});

  @override
  State<SituationB2> createState() => _SituationB2State();
}

class _SituationB2State extends State<SituationB2> {
  final List<Color> colors = [
    Colors.blue,
    Colors.red,
    Colors.green,
  ];

  final int totalBlueCircles = 6;

  int selectedBlueCount = 0;
  String warningMessage = '';

  /// 🔹 لتتبع الدوائر التي تم الضغط عليها
  late List<bool> pressed;

  @override
  void initState() {
    super.initState();
    pressed = List.generate(18, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('لعبة الألوان 🎨')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// السؤال
            const Text(
              'اضغط على جميع الدوائر الزرقاء 🔵',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),
            const Divider(thickness: 2),
            const SizedBox(height: 10),

            /// التحذير المرح
            if (warningMessage.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: const [
                    Text('😅', style: TextStyle(fontSize: 22)),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'هذا مش اللون الأزرق 😄 ركّز شوي!',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),

            /// الدوائر
            Expanded(
              child: GridView.builder(
                itemCount: 18,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  final color = colors[index % colors.length];

                  return GestureDetector(
                    onTap: () {
                      if (pressed[index]) return;

                      setState(() {
                        pressed[index] = true;

                        if (color == Colors.blue) {
                          selectedBlueCount++;
                          warningMessage = '';

                          if (selectedBlueCount == totalBlueCircles) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const SituationB3(),
                              ),
                            );
                          }
                        } else {
                          warningMessage =
                              'هذا مش اللون الأزرق 😄 ركّز شوي!';
                        }
                      });
                    },
                    child: Opacity(
                      opacity: pressed[index] ? 0.4 : 1,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: color,
                        ),
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