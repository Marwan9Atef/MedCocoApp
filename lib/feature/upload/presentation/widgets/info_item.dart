import 'package:flutter/cupertino.dart';
import 'package:valo/core/theme/app_color.dart';
import 'package:valo/core/theme/app_style.dart';

import '../../data/models/info_item_model.dart';

class InfoItem extends StatelessWidget {
  const InfoItem({super.key,required this.infoItemModel,required this.index,this.isColumn=false});
  final InfoItemModel infoItemModel;
  final int index;
  final bool isColumn;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:isColumn? EdgeInsets.only(bottom: 16): index==2?EdgeInsets.zero:const EdgeInsets.only(right: 16),
      child: Container(
        width: isColumn? double.infinity:null,
        padding: const EdgeInsets.all(24),
        decoration: ShapeDecoration(
          color: const Color(0xFF18181B),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 0.80,
              color: AppColor.black,
            ),
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(fit: BoxFit.scaleDown,child: Text(infoItemModel.title,style: AppStyles.styleRegular16(context),)),
            const SizedBox(height: 9),
            FittedBox(fit: BoxFit.scaleDown,child: Text(infoItemModel.description,style: AppStyles.styleRegular14(context),))

          ],
        ),


      ),
    );
  }
}
