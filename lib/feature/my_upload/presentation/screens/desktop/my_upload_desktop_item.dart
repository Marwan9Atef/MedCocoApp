import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:medcoco/core/di/service_locator.dart';
import 'package:medcoco/core/generated/assets.dart';
import 'package:medcoco/core/routes/route_center.dart';
import 'package:medcoco/core/theme/app_style.dart';
import 'package:medcoco/core/utils/app_snack_bars.dart';
import 'package:medcoco/core/widget/remove_container.dart';
import 'package:medcoco/core/widget/simple_loading_indicator.dart';
import 'package:medcoco/feature/my_upload/data/models/my_images_response_model.dart';
import 'package:medcoco/feature/my_upload/presentation/cubit/my_upload_cubit.dart';
import 'package:medcoco/feature/my_upload/presentation/cubit/remove_one_image_cubit.dart';
import 'package:medcoco/feature/my_upload/presentation/cubit/remove_one_image_states.dart';

class MyUploadDesktopItem extends StatelessWidget {
  const MyUploadDesktopItem({super.key, required this.image});
  final MyImageModel image;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: const Color(0xff18181B),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.only(
              topLeft: Radius.circular(14),
              bottomLeft: Radius.circular(14),
            ),
            clipBehavior: Clip.antiAlias,
            child: CachedNetworkImage(
              placeholder: (context, url) =>
                  const Center(child: SimpleLoadingIndicator()),
              errorWidget: (context, url, error) =>
                  const Center(child: Icon(Icons.error)),
              imageUrl: image.fileUrl,
              fit: BoxFit.fill,
              width: 200,
              height: 200,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(image.filename, style: AppStyles.styleRegular20(context)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        context.push(
                          RouteCenter.fullScreenImage,
                          extra: image.fileUrl,
                        );
                      },
                      mouseCursor: SystemMouseCursors.click,
                      child: SvgPicture.asset(
                        AppAssets.detailsContainer,
                        fit: BoxFit.scaleDown,
                        height: 36,
                        width: 36,
                      ),
                    ),
                    const SizedBox(width: 12),
                    BlocProvider(
                      create: (context) =>
                          serviceLocator<RemoveOneImageCubit>(),
                      child:
                          BlocConsumer<
                            RemoveOneImageCubit,
                            RemoveOneImageStates
                          >(
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
                            builder: (context, state) {
                              final isLoading = state is RemoveOneImageLoading;
                              return AbsorbPointer(
                                absorbing: isLoading,
                                child: RemoveContainer(
                                  isLoading: isLoading,
                                  onTap: () async {
                                   await context
                                        .read<RemoveOneImageCubit>()
                                        .remmoveOneImageFromMyUpload(
                                          image.imageId,
                                        );
                                    if (!context.mounted) return;
                                    context.read<MyUploadCubit>().getMyImages();
                                  },
                                ),
                              );
                            },
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
