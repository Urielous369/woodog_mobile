import 'package:flutter/material.dart';
import 'package:woodog_app/main.dart';
import 'package:woodog_app/models/user_model.dart';
import 'package:woodog_app/responsive/size_config.dart';
import 'package:woodog_app/routers/app_routes.dart';
import 'package:woodog_app/screens/login_page.dart';
import 'package:woodog_app/services/api_response.dart';
import 'package:woodog_app/services/user_service.dart';
import 'package:woodog_app/utils/constants/api_constants.dart';
import 'package:woodog_app/utils/constants/color.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  User? user;
  bool loading = true;

  void getUserProfileInfo() async {
    ApiResponse response = await getUserProfile();

    if (response.message == null) {
      setState(() {
        user = response.data as User;
        loading = false;
      });
    } else if (response.message == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const OnboardingScreen()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.message}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfigs().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(
              height: SizeConfigs.screenHeight! * 0.08,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      "Profil",
                      style:
                          TextStyle(fontSize: 34, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () {
                    logout().then((value) => {
                          AppRoutes.pushAndRemoveUntil(
                            context,
                            const OnboardingScreen(),
                          )
                        });
                  },
                )
              ],
            ),
            SizedBox(
              height: SizeConfigs.screenHeight! * 0.02,
            ),
            const ProfilePic(image: "assets/images/walker_3.jpeg"),
            Text(
              "Annette Black",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Divider(height: 16.0 * 2),
            const Info(
              infoKey: "Location",
              info: "New York, NYC",
            ),
            const Info(
              infoKey: "Email Address",
              info: "demo@mail.com",
            ),
            const SizedBox(height: 16.0),
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 160,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 48),
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () {},
                  child: const Text("Edit profile"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    super.key,
    required this.image,
    this.isShowPhotoUpload = false,
    this.imageUploadBtnPress,
  });

  final String image;
  final bool isShowPhotoUpload;
  final VoidCallback? imageUploadBtnPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color:
              Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.08),
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(image),
          ),
          InkWell(
            onTap: imageUploadBtnPress,
            child: const CircleAvatar(
              radius: 13,
              backgroundColor: kPrimaryColor,
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Info extends StatelessWidget {
  const Info({
    super.key,
    required this.infoKey,
    required this.info,
  });

  final String infoKey, info;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            infoKey,
            style: TextStyle(
              color: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .color!
                  .withOpacity(0.8),
            ),
          ),
          Text(info),
        ],
      ),
    );
  }
}
