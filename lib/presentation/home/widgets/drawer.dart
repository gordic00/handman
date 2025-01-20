import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handman/core/assets/app_vectors.dart';
import 'package:handman/core/helper/app_navigator.dart';
import 'package:handman/presentation/auth/pages/singin.dart';
import 'package:handman/presentation/home/pages/home.dart';
import 'package:handman/service/auth_local_service.dart';
import 'package:handman/service_locator.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
