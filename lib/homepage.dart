import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helping_hand/add_child.dart';
import 'package:helping_hand/homecontent.dart';
import 'package:helping_hand/parenteProfile.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

int _currentScreenIndex = 1 ;
List<Widget> _screens = [
  AddChild(),
  HomeContent(),
ParenteProfile()
];
class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: _screens[_currentScreenIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentScreenIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index){
          setState(() {
            _currentScreenIndex = index ;
          });
        },
        unselectedItemColor: Colors.white,
        selectedItemColor: const Color.fromRGBO(70, 236, 213, 0.8),
        selectedFontSize: 12,
        unselectedFontSize: 10,
        backgroundColor: const Color(0xFF0A2F3B),
        
        items: [
          
          BottomNavigationBarItem(
            icon: Icon(_currentScreenIndex == 1
              ? CupertinoIcons.add
              : CupertinoIcons.add),
            label: "أضف ابنك",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _currentScreenIndex == 0
              ? CupertinoIcons.house_fill
              : CupertinoIcons.house),
            label: "الرئيسة",
          ),
          BottomNavigationBarItem(
            icon: Icon(_currentScreenIndex == 2
              ? CupertinoIcons.profile_circled
              : CupertinoIcons.profile_circled),
            label: "ملفي الشخصي",
          ),
        ],
      ),
      
    );
  }
}
