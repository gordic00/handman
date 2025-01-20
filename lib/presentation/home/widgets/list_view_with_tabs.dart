import 'package:flutter/material.dart';
import 'package:handman/data/entity/test_item.dart';
import 'package:handman/data/model/load_req_params.dart';
import 'package:handman/service/test_service.dart';
import 'package:handman/service_locator.dart';

class ListViewWithTabs extends StatefulWidget {
  final String search;

  const ListViewWithTabs({super.key, required this.search});

  @override
  State<ListViewWithTabs> createState() => _ListViewWithTabsState();
}

class _ListViewWithTabsState extends State<ListViewWithTabs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final Map<int, ScrollController> _scrollControllers = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    for (int i = 0; i < 2; i++) {
      _scrollControllers[i] = ScrollController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.white,
            indicatorColor: Colors.blueGrey,
            tabs: const [
              Tab(text: 'JOBS'),
              Tab(text: 'WORKERS'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: List.generate(2, (index) {
                return KeepAlive(
                  child: ListViewWidget(
                    search: widget.search,
                    work: index == 0,
                    scrollController: _scrollControllers[index]!,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    for (var controller in _scrollControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }
}

class ListViewWidget extends StatefulWidget {
  final String search;
  final bool work;
  final ScrollController scrollController;

  const ListViewWidget({
    super.key,
    required this.search,
    required this.work,
    required this.scrollController,
  });

  @override
  State<ListViewWidget> createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget>
    with AutomaticKeepAliveClientMixin {
  final testService = sl<TestService>();
  List<TestItem> items = [];
  int page = 0;
  bool isLoading = false;
  final int size = 20;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _fetchItems();
    widget.scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (widget.scrollController.position.pixels >=
            widget.scrollController.position.maxScrollExtent - 200 &&
        !isLoading) {
      _fetchItems();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
      controller: widget.scrollController,
      itemCount: items.length + (isLoading ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < items.length) {
          final item = items[index];
          final imageUrl = Uri.tryParse(item.imgUrl ?? '')?.isAbsolute == true
              ? item.imgUrl
              : null;

          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: imageUrl != null
                  ? Image.network(
                      imageUrl,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image),
                    )
                  : const Icon(Icons.image),
              title: Text(item.title),
              subtitle: Text(item.description),
            ),
          );
        } else {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

  Future<void> _fetchItems() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    try {
      final results = await testService.load(
        LoadReqParams(search: widget.search, page: page, size: size),
      );

      setState(() {
        items.addAll(results);
        page++;
      });
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load items. Please try again.')),
        );
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }
}

class KeepAlive extends StatefulWidget {
  final Widget child;

  const KeepAlive({super.key, required this.child});

  @override
  State<KeepAlive> createState() => _KeepAliveState();
}

class _KeepAliveState extends State<KeepAlive>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}
