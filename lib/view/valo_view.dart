import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valo/feature/home/presentation/cubit/page_cubit.dart';
import 'package:valo/feature/home/presentation/desktop/desktop_app_bar.dart';
import '../core/theme/app_color.dart';
import '../feature/history/presentation/shared/history_page.dart';
import '../feature/upload/shared/upload_page.dart';
import '../feature/upload/presentation/widgets/custom_nav_bar.dart';

class ValoView extends StatelessWidget {
  const ValoView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PageCubit(),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth > 800;

          return Scaffold(
            appBar: isDesktop
                ? const PreferredSize(
                    preferredSize: Size.fromHeight(kToolbarHeight),
                    child: DesktopAppBar(),
                  )
                : null,
            backgroundColor: AppColor.anotherBlack,
            bottomNavigationBar: isDesktop ? null : const CustomNavBar(),
            body: BlocBuilder<PageCubit, int>(
              builder: (context, currentPage) {
                return IndexedStack(
                  index: currentPage,
                  children: const [
                    UploadPage(),
                    HistoryPage(),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
