import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:handman/core/assets/app_icons.dart';
import 'package:handman/core/helper/app_navigator.dart';
import 'package:handman/presentation/home/pages/home.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController textCon = TextEditingController();
    return Container(
      margin: const EdgeInsets.only(top: 0, left: 20, right: 20),
      // decoration: BoxDecoration(boxShadow: [
      //   BoxShadow(
      //     color: Colors.black.withValues(alpha: 0.1),
      //     blurRadius: 40,
      //     spreadRadius: 0.0,
      //   ),
      // ]),
      child: TextField(
        controller: textCon,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: 'Search',
            hintStyle: const TextStyle(
              color: Colors.blueGrey,
              fontSize: 14,
            ),
            contentPadding: const EdgeInsets.all(15),
            suffixIcon: GestureDetector(
              onTap: () {
                AppNavigator.pushReplacement(
                    context,
                    HomePage(
                      search: textCon.text,
                    ));
              },
              child: SizedBox(
                width: 100,
                child: IntrinsicHeight(
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    const VerticalDivider(
                      indent: 10,
                      endIndent: 10,
                      color: Colors.black,
                      thickness: 0.1,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(AppIcons.search),
                    ),
                  ]),
                ),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            )),
      ),
    );
  }
}
