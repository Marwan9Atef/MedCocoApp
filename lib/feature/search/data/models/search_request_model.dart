class SearchRequestModel {
  final String query;
  final int topK;

  const SearchRequestModel({required this.query, required this.topK});

  Map<String, dynamic> toJson() {
    return {'query': query, 'top_k': topK};
  }
}
