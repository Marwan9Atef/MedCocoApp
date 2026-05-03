import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:medcoco/core/generated/assets.dart';
import 'package:medcoco/core/routes/route_center.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:medcoco/core/widget/simple_loading_indicator.dart';
import 'package:medcoco/feature/my_upload/presentation/cubit/remove_one_image_cubit.dart';
import 'package:medcoco/feature/my_upload/presentation/cubit/remove_one_image_states.dart';

class MyUploadMobileImage extends StatelessWidget {
  const MyUploadMobileImage({
    super.key,
    required this.imagePath,
    required this.imageId,
  });
  final String imagePath;
  final String imageId;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(14)),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.passthrough,
        children: [
          InkWell(
            onTap: () {
              context.push(RouteCenter.fullScreenImage, extra: imagePath);
            },
            mouseCursor: SystemMouseCursors.click,
            child: CachedNetworkImage(
              placeholder: (context, url) =>
                  const Center(child: SimpleLoadingIndicator()),
              errorWidget: (context, url, error) =>
                  const Center(child: Icon(Icons.error)),
              imageUrl: imagePath,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: BlocBuilder<RemoveOneImageCubit, RemoveOneImageStates>(
              builder: (context, state) {
                return InkWell(
                  onTap:
                      (state is RemoveOneImageLoading &&
                          state.imageId == imageId)
                      ? null
                      : () async {
                          await context
                              .read<RemoveOneImageCubit>()
                              .remmoveOneImageFromMyUpload(imageId);
                        },
                  mouseCursor: SystemMouseCursors.click,
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child:
                        (state is RemoveOneImageLoading &&
                            state.imageId == imageId)
                        ? const SimpleLoadingIndicator()
                        : SvgPicture.asset(
                            AppAssets.imagesRemoveIcon,
                            width: 22,
                            height: 22,
                          ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
