import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:medcoco/core/widget/simple_loading_indicator.dart';
import 'package:medcoco/feature/my_upload/presentation/cubit/my_upload_cubit.dart';
import 'package:medcoco/feature/my_upload/presentation/cubit/my_upload_states.dart';
import 'package:medcoco/feature/my_upload/presentation/screens/desktop/my_upload_desktop_list.dart';
import 'package:medcoco/feature/my_upload/presentation/screens/mobile/my_upload_mobile_list.dart';
import 'package:medcoco/feature/my_upload/presentation/shared/my_upload_header.dart';

class MyUploadPage extends StatefulWidget {
  const MyUploadPage({super.key});

  @override
  State<MyUploadPage> createState() => _MyUploadPageState();
}

class _MyUploadPageState extends State<MyUploadPage> {
  @override
  void initState() {
    super.initState();

    context.read<MyUploadCubit>().getMyImages();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                } else if (state is MyUploadFailure) {
                  return Center(child: Text(state.error));
                } else if (state is MyUploadSuccess) {
                  return RefreshIndicator(
                    onRefresh: () {
                      return context.read<MyUploadCubit>().getMyImages();
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BlocSelector<MyUploadCubit, MyUploadStates, int>(
                          selector: (state) {
                            if (state is MyUploadSuccess) {
                              return state.result.images.length;
                            }
                            return 0;
                          },
                          builder: (context, numberOfImages) {
                            return MyUploadHeader(
                              numberOfImages: numberOfImages,
                            );
                          },
                        ),
                        if (!isDesktop) const SizedBox(height: 16),
                        Expanded(
                          child: BlocBuilder<MyUploadCubit, MyUploadStates>(
                            builder: (context, state) {
                              if (state is MyUploadSuccess) {
                                return isDesktop
                                    ? MyUploadDesktopList(
                                        images: state.result.images,
                                      )
                                    : MyUploadMobileList(
                                        images: state.result.images,
                                      );
                              }
                              return const SizedBox();
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          );
        },
      ),
    );
  }
}
