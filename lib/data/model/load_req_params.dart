// ignore_for_file: public_member_api_docs, sort_constructors_first

class LoadReqParams {
  final String search;
  final int page;
  final int size;

  LoadReqParams({required this.search, required this.page, required this.size});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'search': search,
      'page': page,
      'size': size,
    };
  }
}
