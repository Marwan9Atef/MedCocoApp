import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medcoco/core/di/service_locator.dart';
import 'package:medcoco/core/theme/app_color.dart';
import 'package:medcoco/core/theme/app_style.dart';
import 'package:medcoco/feature/upload/presentation/cubit/upload_images_cubit.dart';
import 'package:medcoco/feature/upload/presentation/cubit/upload_process_cubit.dart';

import '../widgets/before_search.dart';
import '../widgets/upload_item.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text("Upload Medical Image", style: AppStyles.styleRegular36(context)),
        const SizedBox(height: 8),
        Text("Upload a medical image to search for similar cases", style: AppStyles.styleRegular16(context).copyWith(color: AppColor.gray)),
        const SizedBox(height: 34),
        const BeforeSearch(),
        const SizedBox(height: 23),
        MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => UploadImagesCubit()),
            BlocProvider(
              create: (_) => serviceLocator<UploadProcessCubit>()..init(),
            ),
          ],
          child: const UploadItem(),
        ),
      ],
    );
  }
}
