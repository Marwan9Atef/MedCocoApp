import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medcoco/core/di/service_locator.dart';
import 'package:medcoco/core/utils/app_snack_bars.dart';
import 'package:medcoco/core/widget/advance_loading_indicator.dart';
import 'package:medcoco/core/widget/empty_result_indicator.dart';
import 'package:medcoco/core/widget/error_indicator.dart';
import 'package:medcoco/feature/my_upload/presentation/cubit/my_upload_cubit.dart';
import 'package:medcoco/feature/my_upload/presentation/cubit/my_upload_states.dart';
import 'package:medcoco/feature/my_upload/presentation/cubit/remove_one_image_cubit.dart';
import 'package:medcoco/feature/my_upload/presentation/cubit/remove_one_image_states.dart';
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
    return BlocProvider(
      create: (context) => serviceLocator<RemoveOneImageCubit>(),
      child: BlocListener<RemoveOneImageCubit, RemoveOneImageStates>(
        listener: (context, state) {
          if (state is RemoveOneImageSuccess) {
            AppSnackBars.showSuccessSnackBar(
              context: context,
              message: 'Image removed successfully',
            );
            context.read<MyUploadCubit>().getMyImages();
          } else if (state is RemoveOneImageFailure) {
            AppSnackBars.showErrorSnackBar(
              context: context,
              message: state.error,
            );
          }
        },
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
                      return const Center(child: AdvanceLoadingIndicator());
                    } else if (state is MyUploadFailure) {
                      return ErrorIndicator(
                        onPressed: () {
                          context.read<MyUploadCubit>().getMyImages();
                        },
                      );
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
                                    if (state.result.images.isEmpty) {
                                      return const EmptyResultIndicator(
                                        subMessage:
                                            "No images have been uploaded yet.",
                                      );
                                    }

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
        ),
      ),
    );
  }
}
