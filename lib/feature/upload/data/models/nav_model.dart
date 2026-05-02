import '../../../../core/generated/assets.dart';

class NavModel {
  final String title;
  final String icon;

  const NavModel({required this.title,required this.icon});
  static final List<NavModel>navList= [
    NavModel(title: "Upload", icon: AppAssets.imagesUploadIcon),
        NavModel(title: "My Uploads", icon: AppAssets.imagesMyUploadIcon),
    NavModel(title: "History", icon: AppAssets.imagesHistoryIcon),
    NavModel(title: "Logout", icon: AppAssets.imagesLogoutIcon),
  ];
}