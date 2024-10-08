import 'package:flutter/material.dart';
import 'package:woodog_app/models/suggested_walker_model.dart';
import 'package:woodog_app/models/walker_model.dart';
import 'package:woodog_app/screens/login_page.dart';
import 'package:woodog_app/screens/suggested_walker_details_page.dart';
import 'package:woodog_app/screens/walker_details_page.dart';
import 'package:woodog_app/services/api_response.dart';
import 'package:woodog_app/services/get_all_suggested_walkers_service.dart';
import 'package:woodog_app/services/get_all_walkers_service.dart';
import 'package:woodog_app/services/user_service.dart';
import 'package:woodog_app/utils/constants/api_constants.dart';
import 'package:woodog_app/widgets/suggested_walker_info_card.dart';
import 'package:woodog_app/widgets/walkers_info_medium_card.dart';

class SuggestedWalkersCardList extends StatefulWidget {
  const SuggestedWalkersCardList({super.key});

  @override
  State<SuggestedWalkersCardList> createState() => _SuggestedWalkersCardListState();
}

class _SuggestedWalkersCardListState extends State<SuggestedWalkersCardList> {
  bool isLoading = true;

  List<SuggestedWalker> suggestedWalkersList = [];

  Future<void> fetchWalkers() async {
  ApiResponse response = await getAllSuggestedWalkers();

  if (response.message == null) {
    List<dynamic> suggestedWalkersData = response.data as List<dynamic>;

    suggestedWalkersList = suggestedWalkersData
        .map<SuggestedWalker>((json) => SuggestedWalker(
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
            itemCount: suggestedWalkersList.length,
            itemBuilder: (context, index) {
              SuggestedWalker suggestedWalker = suggestedWalkersList[index];
              return Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: (suggestedWalkersList.length - 1) == index ? 16 : 0,
              ),
              child: SuggestedWalkersInfoCard(
                image: suggestedWalker.photo_url ?? '',
                name: suggestedWalker.fullName ?? '',
                location: suggestedWalker.distance_location ?? '',
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SuggestedWalkerDetailsPage(
                            suggestedWalkerView: suggestedWalker,
                          )));
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
