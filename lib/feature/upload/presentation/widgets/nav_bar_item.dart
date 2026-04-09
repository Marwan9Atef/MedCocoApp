import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:valo/core/theme/app_color.dart';

import '../../data/models/nav_model.dart';

class NavBarItem extends StatelessWidget {
  const NavBarItem({super.key, required this.navModel});

  final NavModel navModel;

  bool get _isLogout => navModel.title == "Logout";

  @override
  Widget build(BuildContext context) {
    return NavigationDestination(
      icon: SvgPicture.asset(
        navModel.icon,
        colorFilter: _isLogout
            ? const ColorFilter.mode(AppColor.red, BlendMode.srcIn)
            : null,
      ),
      label: navModel.title,
      selectedIcon: SvgPicture.asset(
        navModel.icon,
        colorFilter: ColorFilter.mode(
          _isLogout ? AppColor.red : AppColor.white,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
