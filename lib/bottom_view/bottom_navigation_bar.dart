import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woodog_app/responsive/size_config.dart';
import 'package:woodog_app/screens/discussion_page.dart';
import 'package:woodog_app/screens/home_page.dart';
import 'package:woodog_app/screens/moments_page.dart';
import 'package:woodog_app/screens/profil_page.dart';
import 'package:woodog_app/utils/constants/color.dart';

class BottomBarPage extends StatefulWidget {
  const BottomBarPage({super.key});

  @override
  State<BottomBarPage> createState() => _BottomBarPageState();
}

class _BottomBarPageState extends State<BottomBarPage> {
  int currentIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const MomentsPage(),
    const DiscussionPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfigs().init(context);
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: kWhiteColor,
          elevation: 0,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/icons/svg/home.svg", color: const Color(0xFFAEAEB2),),
              activeIcon: SvgPicture.asset("assets/icons/svg/home.svg", color: Colors.black,),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/icons/svg/persons.svg", color: const Color(0xFFAEAEB2),),
              activeIcon: SvgPicture.asset("assets/icons/svg/persons.svg", color: Colors.black,),
              label: 'Moments',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/icons/svg/chat.svg", color: const Color(0xFFAEAEB2),),
              activeIcon: SvgPicture.asset("assets/icons/svg/chat.svg", color: Colors.black,),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/icons/svg/profile.svg", color: const Color(0xFFAEAEB2),),
              activeIcon: SvgPicture.asset("assets/icons/svg/profile.svg", color: Colors.black,),
              label: 'Profile',
            ),
          ],
          currentIndex: currentIndex,
          selectedItemColor: kWhiteColor,
          unselectedItemColor: Colors.grey,
          onTap: (int intValue) {
            setState(() {
              currentIndex = intValue;
            });
          },
          selectedIconTheme: const IconThemeData(
            color: kWhiteColor,
          ),
        ),
      ),
      body: IndexedStack(
        children: [
          _widgetOptions.elementAt(currentIndex),
        ],
      ),
    );
  }
}
