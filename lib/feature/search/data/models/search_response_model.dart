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

  Map<String, dynamic> toJson() => {
        'query': query,
        'count': count,
        'results': results.map((result) => result.toJson()).toList(),
      };

  SearchResponseModel copyWith({
    String? query,
    int? count,
    List<SearchResultModel>? results,
  }) {
    return SearchResponseModel(
      query: query ?? this.query,
      count: count ?? this.count,
      results: results ?? this.results,
    );
  }
}

class SearchResultModel {
  final String imageId;
  final String filename;
  final String savedFilename;
  final String fileUrl;
  final double similarityScore;
  final String caption;
  final String cachedAt;

  const SearchResultModel({
    required this.imageId,
    required this.filename,
    required this.savedFilename,
    required this.fileUrl,
    required this.similarityScore,
    required this.caption,
    this.cachedAt = '',
  });

  factory SearchResultModel.fromJson(Map<String, dynamic> json) =>
      SearchResultModel(
        imageId: json['image_id'] as String,
        filename: json['filename'] as String,
        savedFilename: json['saved_filename'] as String,
        fileUrl: json['file_url'] as String,
        similarityScore: (json['similarity_score'] as num).toDouble(),
        caption: json['caption'] as String,
        cachedAt: json['cached_at'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        'image_id': imageId,
        'filename': filename,
        'saved_filename': savedFilename,
        'file_url': fileUrl,
        'similarity_score': similarityScore,
        'caption': caption,
        'cached_at': cachedAt,
      };

  SearchResultModel copyWith({
    String? imageId,
    String? filename,
    String? savedFilename,
    String? fileUrl,
    double? similarityScore,
    String? caption,
    String? cachedAt,
  }) {
    return SearchResultModel(
      imageId: imageId ?? this.imageId,
      filename: filename ?? this.filename,
      savedFilename: savedFilename ?? this.savedFilename,
      fileUrl: fileUrl ?? this.fileUrl,
      similarityScore: similarityScore ?? this.similarityScore,
      caption: caption ?? this.caption,
      cachedAt: cachedAt ?? this.cachedAt,
    );
  }
}
