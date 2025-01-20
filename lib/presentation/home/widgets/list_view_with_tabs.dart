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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
              children: [
                ListViewWidget(
                  search: widget.search,
                  work: true,
                ),
                ListViewWidget(
                  search: widget.search,
                  work: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class ListViewWidget extends StatefulWidget {
  final String search;
  final bool work;

  const ListViewWidget({super.key, required this.search, required this.work});

  @override
  State<ListViewWidget> createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  final ScrollController _scrollController = ScrollController();
  final testService = sl<TestService>();
  List<TestItem> items = [];
  int page = 0;
  bool isLoading = false;
  final int size = 20;
  double _previousScrollPosition = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchItems();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final currentPosition = _scrollController.position.pixels;
    final maxScrollExtent = _scrollController.position.maxScrollExtent;

    if (currentPosition > _previousScrollPosition &&
        currentPosition >= maxScrollExtent - 200 &&
        !isLoading) {
      _fetchItems();
    }

    _previousScrollPosition = currentPosition > _previousScrollPosition
        ? currentPosition
        : _previousScrollPosition;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
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

    _setIsLoading(true);

    try {
      final results = widget.work
          ? await testService.load(
              LoadReqParams(search: widget.search, page: page, size: size),
            )
          : await testService.load(
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
      _setIsLoading(false);
    }
  }

  void _setIsLoading(bool value) {
    if (!mounted) return;
    setState(() {
      isLoading = value;
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }
}
