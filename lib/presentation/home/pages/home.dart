import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handman/core/assets/app_vectors.dart';
import 'package:handman/core/helper/app_navigator.dart';
import 'package:handman/presentation/home/widgets/drawer.dart';
import 'package:handman/presentation/home/widgets/home_column_list.dart';

class HomePage extends StatefulWidget {
  final String search;
  const HomePage({super.key, required this.search});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> pageList = [];
  int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    pageList = _populatePageList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      drawer: DrawerWidget(),
      body: pageList[selectedIndex], // Fixed here
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        backgroundColor: Colors.blueAccent,
        iconSize: 24.0,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
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
              HomePage(search: ''),
            ); // Change to notification page when created.
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

  List<Widget> _populatePageList() {
    return [
      HomeColumnListWidget(search: widget.search),
      Container(),
      Center(
        child: Text('asdasdf'),
      ),
    ];
  }
}
