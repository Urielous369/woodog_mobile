import 'package:flutter/material.dart';
import 'package:woodog_app/models/walker_model.dart';
import 'package:woodog_app/routers/app_routes.dart';
import 'package:woodog_app/screens/login_page.dart';
import 'package:woodog_app/screens/walker_details_page.dart';
import 'package:woodog_app/services/api_response.dart';
import 'package:woodog_app/services/get_all_walkers_service.dart';
import 'package:woodog_app/services/user_service.dart';
import 'package:woodog_app/utils/constants/api_constants.dart';
import 'package:woodog_app/widgets/walkers_info_medium_card.dart';

class WalkersMediumCardList extends StatefulWidget {
  const WalkersMediumCardList({super.key});

  @override
  State<WalkersMediumCardList> createState() => _WalkersMediumCardListState();
}

class _WalkersMediumCardListState extends State<WalkersMediumCardList> {
  bool isLoading = true;

  List<Walker> walkersList = [];

  Future<void> fetchWalkers() async {
  ApiResponse response = await getAllWalkers();

  if (response.message == null) {
    List<dynamic> walkersData = response.data as List<dynamic>;

    walkersList = walkersData
        .map<Walker>((json) => Walker(
            id: json['id'],
            age: json['age'],
            description: json['description'],
            distance_location: json['distance_location'],
            fullName: json['fullName'],
            monthOfExperience: json['month_of_experience'],
            photo_url: json['photo_url']))
        .toList();

    setState(() {
      isLoading = false;
    });
  } else if (response.message == unauthorized) {
    logout().then((value) => {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LoginPage()),
              (route) => false)
        });
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('${response.message}'),
    ));
  }
}


 @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    fetchWalkers();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 230,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: walkersList.length,
            itemBuilder: (context, index) {
              Walker walker = walkersList[index];
              return Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: (walkersList.length - 1) == index ? 16 : 0,
              ),
              child: WalkersInfoMediumCard(
                image: walker.photo_url ?? '',
                name: walker.fullName ?? '',
                location: walker.distance_location ?? '',
                press: () {
                  AppRoutes.pushToNextPage(context, WalkerDetailsPage(
                    walkerView: walker,
                  ));
                },
              ),
            );
            },
          ),
        ),
      ],
    );
  }
}
