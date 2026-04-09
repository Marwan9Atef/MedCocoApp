import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valo/core/utils/context_util.dart';
import 'package:valo/feature/home/presentation/cubit/page_cubit.dart';
import 'package:valo/feature/home/presentation/desktop/desktop_app_bar.dart';
import 'package:valo/feature/upload/presentation/cubit/upload_images_cubit.dart';
import 'package:valo/view/valo_desktop_layout.dart';
import 'package:valo/view/valo_mobile_view.dart';
import '../core/theme/app_color.dart';
import '../core/widget/adabtive_layout_widget.dart';
import '../feature/upload/presentation/widgets/custom_nav_bar.dart';


class ValoView extends StatelessWidget {
  const ValoView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PageCubit()),
        BlocProvider(create: (context) => UploadImagesCubit()),
      ],
      child: Scaffold(
        appBar: context.screenWidth > 800 ? PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: DesktopAppBar()) : null,
        backgroundColor: AppColor.anotherBlack,
        bottomNavigationBar: context.screenWidth > 800
            ? null
            : const CustomNavBar(),
        body: AdaptiveLayoutWidget(
          mobileLayout: (context) => SafeArea(child: const ValoMobileView()),
          desktopLayout: (context) => ValoDesktopLayout(),
        ),

      ),
    );
  }
}
