import 'package:flutter/material.dart';
import 'package:handman/presentation/home/widgets/list_view_with_tabs.dart';
import 'package:handman/presentation/home/widgets/search_field.dart';

class HomeColumnListWidget extends StatefulWidget {
  final String search;
  const HomeColumnListWidget({super.key, required this.search});

  @override
  State<HomeColumnListWidget> createState() => _HomeColumnListWidgetState();
}

class _HomeColumnListWidgetState extends State<HomeColumnListWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
