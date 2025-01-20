import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handman/core/assets/app_icons.dart';
import 'package:handman/core/assets/app_vectors.dart';
import 'package:handman/core/helper/app_navigator.dart';
import 'package:handman/presentation/home/widgets/list_view_with_tabs.dart';
import 'package:handman/presentation/home/widgets/search_field.dart';

class HomePage extends StatefulWidget {
  final String search;
  const HomePage({super.key, required this.search});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      drawer: ,
      body: Column(
        children: [
          SizedBox(
            height: 24,
          ),
          SearchField(),
          SizedBox(
            height: 24,
          ),
          ListViewWithTabs(
            search: widget.search,
          ),
          SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.lightBlue,
      title: SvgPicture.asset(
        AppVectors.appLogo,
        height: 60,
      ),
      centerTitle: true,
      actions: [
        GestureDetector(
          onTap: () {
            AppNavigator.pushReplacement(
                context,
                HomePage(
                  search: '',
                )); //change to notification page when created.
          },
          child: Container(
            margin: const EdgeInsets.all(15),
            width: 37,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.lightBlue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: SvgPicture.asset(AppIcons.bell),
          ),
        ),
      ],
    );
  }
}
