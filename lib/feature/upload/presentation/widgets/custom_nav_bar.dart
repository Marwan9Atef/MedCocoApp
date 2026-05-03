import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medcoco/core/di/service_locator.dart';
import 'package:medcoco/feature/auth/presentation/cubit/auth/auth_cubit.dart';
import 'package:medcoco/feature/history/presentation/cubit/history_cubit.dart';
import 'package:medcoco/feature/home/presentation/cubit/page_cubit.dart';

import '../../data/models/nav_model.dart';
import 'nav_bar_item.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({super.key});

  static const _logoutIndex = 3;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageCubit, int>(
      builder: (context, currentTab) {
        return NavigationBar(
          selectedIndex: currentTab,
          onDestinationSelected: (index) {
            if (index == _logoutIndex) {
              serviceLocator<AuthCubit>().logout();
              serviceLocator<HistoryCubit>().clearHistory();
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
