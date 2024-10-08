import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:woodog_app/screens/login_page.dart';
import 'package:woodog_app/screens/register_page.dart';
import 'package:woodog_app/utils/constants/color.dart';

void main() {
  runApp(const WoodogApp());
}

class WoodogApp extends StatelessWidget {
  const WoodogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: OnboardingScreen(),
      ),
    );
  }
}

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/onboarding_image.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white24,
                Colors.black.withOpacity(0.9),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icons/png/logo.png',
                      height: 60,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("WOO",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w900,
                                fontSize: 22,
                                color: Colors.red)),
                        Text("DOG",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w900,
                                fontSize: 22,
                                color: Colors.red)),
                      ],
                    )
                  ],
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildPageIndicator(isActive: true),
                  _buildPageIndicator(isActive: false),
                  _buildPageIndicator(isActive: false),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                "Too tired to walk your dog?\nLet's help you!",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                    color: kWhiteColor),
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterPage()));
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFFF7F00), // Orange pur
                        Color(0xFFFFA726), // Orange plus clair
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: Center(
                    child: Text('Join our community',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                            color: kWhiteColor)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                },
                child: RichText(
                  text: TextSpan(
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 13, color: kWhiteColor),
                    children: [
                    const TextSpan(
                      text: "Already a member? ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    TextSpan(
                      text: "Sign In",
                      style: TextStyle(
                        color: Colors.orange[900],
                        fontSize: 16,
                      ),
                    )
                  ]),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPageIndicator({required bool isActive}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      width: isActive ? 12.0 : 8.0,
      height: isActive ? 12.0 : 8.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Colors.white : Colors.grey,
      ),
    );
  }
}
