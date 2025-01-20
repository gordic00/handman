import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handman/core/assets/app_vectors.dart';
import 'package:handman/core/helper/app_navigator.dart';
import 'package:handman/presentation/auth/pages/singin.dart';
import 'package:handman/presentation/home/widgets/list_view_with_tabs.dart';
import 'package:handman/presentation/home/widgets/search_field.dart';
import 'package:handman/service/auth_local_service.dart';
import 'package:handman/service_locator.dart';

class HomePage extends StatefulWidget {
  final String search;
  const HomePage({super.key, required this.search});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _onItemTapped(int index) {
    setState(() {
      if (index == 0) {
        AppNavigator.pushReplacement(context, HomePage(search: ''));
      }
      if (index == 1) {
        AppNavigator.pushReplacement(context, HomePage(search: ''));
      }
      if (index == 2) {
        AppNavigator.pushReplacement(context, HomePage(search: ''));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: SvgPicture.asset(
                AppVectors.appLogo,
                height: 60,
              ),
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: const Text('Notifications'),
              onTap: () {
                AppNavigator.pushReplacement(
                    context,
                    HomePage(
                      search: '',
                    ));
              },
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text('Favorites'),
              onTap: () {
                AppNavigator.pushReplacement(
                    context,
                    HomePage(
                      search: '',
                    ));
              },
            ),
            ListTile(
              leading: Icon(Icons.reviews),
              title: Text('Reviews'),
              onTap: () {
                AppNavigator.pushReplacement(
                    context,
                    HomePage(
                      search: '',
                    ));
              },
            ),
            ListTile(
              leading: Icon(Icons.people_alt),
              title: Text('Colaborations'),
              onTap: () {
                AppNavigator.pushReplacement(
                    context,
                    HomePage(
                      search: '',
                    ));
              },
            ),
            ListTile(
              leading: Icon(Icons.notes),
              title: Text('My Adds'),
              onTap: () {
                AppNavigator.pushReplacement(
                    context,
                    HomePage(
                      search: '',
                    ));
              },
            ),
            ListTile(
              leading: Icon(Icons.note_add),
              title: const Text('Post new add'),
              onTap: () {
                AppNavigator.pushReplacement(
                    context,
                    HomePage(
                      search: '',
                    ));
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                AppNavigator.pushReplacement(
                    context,
                    HomePage(
                      search: '',
                    ));
              },
            ),
            ListTile(
              leading: Icon(Icons.emoji_people),
              title: const Text('Contact Us'),
              onTap: () {
                AppNavigator.pushReplacement(context, HomePage(search: ''));
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: const Text('Sing out'),
              onTap: () {
                sl<AuthLocalService>().logout();
                AppNavigator.pushReplacement(context, SigninPage());
              },
            ),
          ],
        ),
      ),
      body: Expanded(
        child: Column(
          children: [
            SizedBox(
              height: 12,
            ),
            SearchField(),
            SizedBox(
              height: 1,
            ),
            ListViewWithTabs(
              search: widget.search,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        backgroundColor: Colors.blueAccent,
        iconSize: 24.0,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped, // Handle item taps
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
            // child: SvgPicture.asset(AppIcons.bell),
            child: Icon(Icons.notifications),
          ),
        ),
      ],
    );
  }
}
