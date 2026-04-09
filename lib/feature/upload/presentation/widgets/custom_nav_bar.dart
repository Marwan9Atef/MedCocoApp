import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:valo/core/routes/route_center.dart';
import 'package:valo/feature/home/presentation/cubit/page_cubit.dart';

import '../../data/models/nav_model.dart';
import 'nav_bar_item.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({super.key});

  static const _logoutIndex = 2;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageCubit, int>(
      builder: (context, currentTab) {
        return NavigationBar(
          selectedIndex: currentTab,
          onDestinationSelected: (index) {
            if (index == _logoutIndex) {
              context.go(RouteCenter.login);
              return;
            }
            if (index == currentTab) return;
            context.read<PageCubit>().setValue(index);
          },
          destinations: NavModel.navList
              .map((e) => NavBarItem(navModel: e))
              .toList(),
        );
      },
    );
  }
}
