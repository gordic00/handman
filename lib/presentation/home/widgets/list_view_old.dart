// import 'package:flutter/material.dart';

// class ListViewWidget extends StatefulWidget {
//   final String search;

//   const ListViewWidget({super.key, required this.search});

//   @override
//   State<StatefulWidget> createState() => _ListViewWidgetState();
// }

// class _ListViewWidgetState extends State<ListViewWidget> {
//   final ScrollController _scrollController = ScrollController();
//   final apiService = sl<ApiService>();
//   List<AddItem> list = [];
//   int page = 0;
//   bool isLoading = false;
//   final int size = 20;

//   @override
//   void initState() {
//     super.initState();
//     _fetchItems();
//     _scrollController.addListener(() {
//       if (_scrollController.position.pixels <
//           _scrollController.position.maxScrollExtent) {
//         _fetchItems();
//       }
//     });
//   }

//   Future<void> _fetchItems() async {
//     if (isLoading) return;

//     setState(() {
//       isLoading = true;
//     });

//     try {
//       final fetchItems = await apiService.getItems(page, size);
//       setState(() {
//         list.addAll(fetchItems);
//         page++;
//       });
//     } catch (error) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to load items. Please try again.')),
//       );
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: ListView.builder(
//         controller: _scrollController,
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         itemCount: list.length + (isLoading ? 1 : 0),
//         itemBuilder: (context, index) {
//           if (index < list.length) {
//             final item = list[index];

//             final imageUrl = Uri.tryParse(item.imgUrl ?? '')?.isAbsolute == true
//                 ? item.imgUrl
//                 : null;

//             return Card(
//               margin: const EdgeInsets.all(8.0),
//               child: ListTile(
//                 leading: imageUrl != null
//                     ? Image.network(
//                         imageUrl,
//                         errorBuilder: (context, error, stackTrace) =>
//                             const Icon(Icons.broken_image),
//                       )
//                     : const Icon(Icons.image),
//                 title: Text(item.title ?? 'No Title'),
//                 subtitle: Text(item.description ?? 'No Description'),
//               ),
//             );
//           } else {
//             return const Padding(
//               padding: EdgeInsets.all(16.0),
//               child: Center(child: CircularProgressIndicator()),
//             );
//           }
//         },
//       ),
//     );
//   }
// }

//   // @override
//   // Widget build(BuildContext context) {
//   //   return BlocProvider(
//   //       create: (cntext) => AddItemsDisplayCubit(),
//   //       child: BlocBuilder<AddItemsDisplayCubit, AddItemsDisplayState>(
//   //         builder: (context, state) {
//   //           if (state is AddItemsLoading && _currentPage == 0) {
//   //             // Initial loading indicator
//   //             return const Center(child: CircularProgressIndicator());
//   //           } else if (state is LoadAddItemsFailure) {
//   //             // Show error message
//   //             return Center(
//   //               child: Column(
//   //                 mainAxisAlignment: MainAxisAlignment.center,
//   //                 children: [
//   //                   const Text('Failed to load items'),
//   //                   ElevatedButton(
//   //                     onPressed: _loadMore,
//   //                     child: const Text('Retry'),
//   //                   ),
//   //                 ],
//   //               ),
//   //             );
//   //           } else if (state is AddItemsLoaded) {
//   //             final items = state.addItems;
//   //             return ListView.builder(
//   //               controller: _scrollController,
//   //               itemCount: items.length + 1, // Extra item for loading indicator
//   //               itemBuilder: (context, index) {
//   //                 if (index < items.length) {
//   //                   final item = items[index];
//   //                   return Card(
//   //                     margin: const EdgeInsets.all(8.0),
//   //                     child: ListTile(
//   //                       leading: item.imgUrl != ''
//   //                           ? Image.network(item.imgUrl)
//   //                           : const Icon(Icons.image),
//   //                       title: Text(item.title ?? 'No Title'),
//   //                       subtitle: Text(item.description ?? 'No Description'),
//   //                     ),
//   //                   );
//   //                 } else if (context.read<AddItemsDisplayCubit>().state
//   //                     is AddItemsLoading) {
//   //                   // Loading indicator
//   //                   return const Center(child: CircularProgressIndicator());
//   //                 } else {
//   //                   // End of list
//   //                   return const SizedBox();
//   //                 }
//   //               },
//   //             );
//   //           }
//   //           return const SizedBox();
//   //         },
//   //       ));
//   // }
