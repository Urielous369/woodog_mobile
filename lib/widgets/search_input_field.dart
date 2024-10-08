import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:woodog_app/responsive/size_config.dart';
import 'package:woodog_app/utils/constants/color.dart';

class SearchInputField extends StatelessWidget {
  const SearchInputField({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfigs().init(context);
    return Container(
      height: SizeConfigs.screenHeight! * 0.07,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: kScaffoldColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              onTap: () {
                
              },
              decoration: InputDecoration(
                icon: const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Icon(Icons.location_on_outlined),
                ),
                border: InputBorder.none,
                hintText: "Kiyv, Ukraine",
                hintStyle: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600, fontSize: 12, color: kGrey),
              ),
            ),
          ),
           Padding(
            padding: const EdgeInsets.only(right: 12),
            child: SvgPicture.asset("assets/icons/svg/filter.svg"),
          )
        ],
      ),
    );
  }
}
