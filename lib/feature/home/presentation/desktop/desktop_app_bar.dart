import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medcoco/core/theme/app_color.dart';
import 'package:medcoco/feature/home/presentation/shared/logout_item.dart';

import '../../../../core/theme/app_style.dart';
import '../../data/item_model.dart';
import '../cubit/page_cubit.dart';
import 'app_bar_item.dart';

class DesktopAppBar extends StatelessWidget {
  const DesktopAppBar({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageCubit, int>(
      builder: (context, currentTab) {
        return AppBar(
          title: Text("Medical Image Search", style: AppStyles.styleRegular20(context),


          ),
          actions: [
            
            ...List.generate(3, (index) =>
              InkWell(
                
                onTap: () {
                  if (currentTab == index) return;
                  context.read<PageCubit>().setValue(index);
                },
                mouseCursor: SystemMouseCursors.click,
                hoverColor: AppColor.blue.withValues(alpha: 0.2),
                focusColor: AppColor.blue.withValues(alpha: 0.2),
                splashColor: AppColor.blue.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
                child: AppBarItem(
                  isActive: currentTab == index,
                  item: ItemModel.items[index],
                ),
              )),
              LogoutItem(),
           
              
              ],


        );
      },
    );
  }
}
