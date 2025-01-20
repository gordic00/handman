import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handman/core/assets/app_vectors.dart';
import 'package:handman/core/helper/app_navigator.dart';
import 'package:handman/presentation/home/widgets/bottom_navigation_bar.dart';
import 'package:handman/presentation/home/widgets/drawer.dart';
import 'package:handman/presentation/home/widgets/home_column_list.dart';

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
      drawer: DrawerWidget(),
      body: Expanded(
        child: HomeColumnListWidget(search: widget.search),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(),
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
      leading: Builder(
        builder: (context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ),
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
            child: Icon(Icons.notifications),
          ),
        ),
      ],
    );
  }
}
