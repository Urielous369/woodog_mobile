import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:woodog_app/responsive/size_config.dart';
import 'package:woodog_app/utils/constants/color.dart';

class InputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  TextInputType? textInputType;
  final Color bgColor;
  IconData? suffixIcon;
  int? maxLength;
  InputField(
      {super.key,
      required this.label,
      required this.controller,
      required this.bgColor,
      this.suffixIcon,
      this.textInputType,
      this.maxLength});

  @override
  Widget build(BuildContext context) {
    SizeConfigs().init(context);
    return Container(
      height: SizeConfigs.screenHeight! * 0.07,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 0.5, color: bgColor)),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              maxLength: maxLength,
              keyboardType: textInputType,
              controller: controller,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  hintText: label,
                  hintStyle: GoogleFonts.workSans(
                      color: kGrey,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.82)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Icon(
              suffixIcon,
              size: 20,
              color: kGrey,
            ),
          )
        ],
      ),
    );
  }
}

class PassWordInput extends StatefulWidget {
  final TextEditingController controller;
  final String text;
  const PassWordInput(
      {super.key, required this.controller, required this.text});

  @override
  State<PassWordInput> createState() => _PassWordInputState();
}

class _PassWordInputState extends State<PassWordInput> {
  bool _isVisiable = false;
  @override
  Widget build(BuildContext context) {
    SizeConfigs().init(context);
    return Container(
      height: SizeConfigs.screenHeight! * 0.07,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: kInputBgColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 0.5, color: kInputBgColor)),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: widget.controller,
              obscureText: _isVisiable ? false : true,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  hintText: widget.text,
                  hintStyle: GoogleFonts.workSans(
                      color: kGrey,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.82)),
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _isVisiable = !_isVisiable;
              });
            },
            icon: Icon(_isVisiable ? Icons.visibility : Icons.visibility_off, color: kGrey, size: 20,),
          ),
        ],
      ),
    );
  }
}
