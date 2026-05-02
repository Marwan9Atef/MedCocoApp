import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medcoco/core/di/service_locator.dart';
import 'package:medcoco/core/widget/simple_loading_indicator.dart';
import 'package:medcoco/feature/my_upload/data/models/my_images_response_model.dart';
import 'package:medcoco/feature/my_upload/presentation/cubit/my_upload_cubit.dart';
import 'package:medcoco/feature/my_upload/presentation/cubit/my_upload_states.dart';
import 'package:medcoco/feature/my_upload/presentation/screens/desktop/my_upload_desktop_list.dart';
import 'package:medcoco/feature/my_upload/presentation/screens/mobile/my_upload_mobile_list.dart';
import 'package:medcoco/feature/my_upload/presentation/shared/my_upload_header.dart';

class MyUploadPage extends StatelessWidget {
  const MyUploadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<MyUploadCubit>()..getMyImages(),
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth > 800;

            return Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: isDesktop ? 12 : 16,
              ),
              child: BlocBuilder<MyUploadCubit, MyUploadStates>(
                builder: (context, state) {
                  if (state is MyUploadLoading) {
                    return const Center(child: SimpleLoadingIndicator());
                  }else if(state is MyUploadSuccess){
            List<MyImageModel> images = state.result.images;
                  return  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const MyUploadHeader(),
                      if (!isDesktop) const SizedBox(height: 16),
                      Expanded(
                        child: isDesktop
                            ? MyUploadDesktopList(images: images)
                            : MyUploadMobileList(images: images),
                      ),
                    ],
                  );
                  }else if(state is MyUploadFailure){
                    return Center(child: Text(state.error));
                  }else{
                    return const SizedBox();
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
