class RemoveOneImageResponseModel {
  final String deleted;
  final String status;

  const RemoveOneImageResponseModel({
    required this.deleted,
    required this.status,
  });

  factory RemoveOneImageResponseModel.fromJson(dynamic json) {
    final data = json is Map<String, dynamic>
        ? json
        : const <String, dynamic>{};

    return RemoveOneImageResponseModel(
      deleted: data['deleted'] as String? ?? '',
      status: data['status'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'deleted': deleted,
        'status': status,
      };

  RemoveOneImageResponseModel copyWith({
    String? deleted,
    String? status,
  }) =>
      RemoveOneImageResponseModel(
        deleted: deleted ?? this.deleted,
        status: status ?? this.status,
      );
}
