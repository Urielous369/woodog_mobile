import 'package:flutter/material.dart';
import 'package:woodog_app/responsive/size_config.dart';
import 'package:woodog_app/utils/constants/color.dart';
import 'package:woodog_app/widgets/search_input_field.dart';
import 'package:woodog_app/widgets/suggested_walker_card_list.dart';
import 'package:woodog_app/widgets/walkers_medium_card_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    SizeConfigs().init(context);
    return Scaffold(
        backgroundColor: kWhiteColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: SizeConfigs.screenHeight! * 0.08,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Home",
                          style: TextStyle(
                              fontSize: 34, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "Explore dog walkers",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF7A7A7A)),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
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
                        child: const Center(
                          child: Row(
                            children: [
                              Icon(
                                Icons.add,
                                color: kWhiteColor,
                                size: 18,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  'Book a walk',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: SizeConfigs.screenHeight! * 0.02,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: SearchInputField(),
              ),
               SizedBox(
                height: SizeConfigs.screenHeight! * 0.03,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Near you", style: TextStyle(fontSize: 34, fontWeight: FontWeight.w700),),
                    Text("View all", style: TextStyle(fontSize: 18, decoration: TextDecoration.underline),),
                ],),
              ),
              const WalkersMediumCardList(),
              const Divider(
                indent: 8,
                endIndent: 8,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Suggested", style: TextStyle(fontSize: 34, fontWeight: FontWeight.w700),),
                    Text("View all", style: TextStyle(fontSize: 18, decoration: TextDecoration.underline),),
                ],),
              ),
              const SuggestedWalkersCardList()
            ],
          ),
        ));
  }
}
