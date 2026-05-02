class SearchResponseModel {
  final String query;
  final int count;
  final List<SearchResultModel> results;

  const SearchResponseModel({
    required this.query,
    required this.count,
    required this.results,
  });

  factory SearchResponseModel.fromJson(Map<String, dynamic> json) =>
      SearchResponseModel(
        query: json['query'] as String,
        count: json['count'] as int,
        results: (json['results'] as List<dynamic>)
            .map((e) => SearchResultModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}

class SearchResultModel {
  final String imageId;
  final String filename;
  final String savedFilename;
  final String fileUrl;
  final double similarityScore;
  final String caption;

  const SearchResultModel({
    required this.imageId,
    required this.filename,
    required this.savedFilename,
    required this.fileUrl,
    required this.similarityScore,
    required this.caption,
  });

  factory SearchResultModel.fromJson(Map<String, dynamic> json) =>
      SearchResultModel(
        imageId: json['image_id'] as String,
        filename: json['filename'] as String,
        savedFilename: json['saved_filename'] as String,
        fileUrl: json['file_url'] as String,
        similarityScore: (json['similarity_score'] as num).toDouble(),
        caption: json['caption'] as String,
      );
}
