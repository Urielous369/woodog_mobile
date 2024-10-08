import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:woodog_app/responsive/size_config.dart';
import 'package:woodog_app/routers/app_routes.dart';
import 'package:woodog_app/screens/chat_page.dart';
import 'package:woodog_app/utils/constants/color.dart';
import 'package:woodog_app/widgets/search_chat_input_field.dart';
import 'package:woodog_app/widgets/search_input_field.dart';

class DiscussionPage extends StatefulWidget {
  const DiscussionPage({super.key});

  @override
  State<DiscussionPage> createState() => _DiscussionPageState();
}

class _DiscussionPageState extends State<DiscussionPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfigs().init(context);
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: SizeConfigs.screenHeight! * 0.08,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              "Chat",
              style: TextStyle(fontSize: 34, fontWeight: FontWeight.w700),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: SearchChatInputField(),
          ),
          SizedBox(
            height: SizeConfigs.screenHeight! * 0.02,
          ),
          Expanded(
            child: ListView(
              children: [
                _buildMessageItem(
                    'Will Knowles', 'Hey! How\'s your dog?', '1min'),
                    const Divider(),
                _buildMessageItem(
                    'Ryan Bond', 'Let\'s go out', '5h'),
                    const Divider(),
                _buildMessageItem(
                    'Sirena Paul', 'Hey! Long time no see', '1min'),
                    const Divider(),
                _buildMessageItem('Matt Chapman',
                    "You fed the dog?", '6h'),
                    const Divider(),
                _buildMessageItem(
                    'Laura Pierce', 'How are you doing', '7h'),
                    const Divider(),
                _buildMessageItem('Hazel Reed', 'Hey! Long time no see',
                    '5h'),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildMessageItem(String name, String message, String time) {
    return InkWell(
      onTap: () {
       AppRoutes.pushToNextPage(context, const ChatPage());
        debugPrint("chat tapped");
      },
      child: ListTile(
        leading: Stack(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: kPrimaryColor,
              ),
            ),
            const Positioned.fill(
              child: Padding(
                padding: EdgeInsets.all(3),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/walker_3.jpeg'),
                ),
              ),
            ),
          ],
        ),
        title: Text(name,
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w700, fontSize: 15, color: kBlackColor)),
        subtitle: Text(message,
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w500, fontSize: 12, color: kGrey)),
        trailing: Text(time,
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w500, fontSize: 12, color: kBlackColor)),
      ),
    );
  }
}
