import '../../../core/generated/assets.dart';

class ItemModel {
  final String title;
  final String iconPath;

  ItemModel({required this.title,required this.iconPath});
  static final List<ItemModel> items=[
    ItemModel(title: "Upload", iconPath: AppAssets.imagesUploadIcon),
        ItemModel(title: "My Uploads", iconPath: AppAssets.imagesMyUploadIcon),
    ItemModel(title: "History", iconPath: AppAssets.imagesHistoryIcon),


  ];



}