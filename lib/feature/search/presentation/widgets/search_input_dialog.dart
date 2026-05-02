import 'package:flutter/material.dart';
import 'package:medcoco/core/theme/app_style.dart';
import 'package:medcoco/core/theme/app_color.dart';

class SearchInputDialog extends StatefulWidget {
  const SearchInputDialog({super.key});

  @override
  State<SearchInputDialog> createState() => _SearchInputDialogState();
}

class _SearchInputDialogState extends State<SearchInputDialog> {
  final TextEditingController _controller = TextEditingController(text: "5");

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xff18181B),
      title: Text(
        "Find Similar Results",
        style: AppStyles.styleRegular20(
          context,
        ).copyWith(color: AppColor.white),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "How many similar images would you like to find?",
            style: AppStyles.styleRegular16(
              context,
            ).copyWith(color: AppColor.gray),
          ),
         
          const SizedBox(height: 8),
          TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColor.black,
              hintText: "Enter number",
              hintStyle: AppStyles.styleRegular16(
                context,
              ).copyWith(color: AppColor.white.withValues(alpha: 0.7)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            style: AppStyles.styleRegular16(
              context,
            ).copyWith(color: AppColor.white),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(null);
          },
          style: TextButton.styleFrom(
            backgroundColor:AppColor.gray.withValues(alpha: 0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          child: Text(
            "Cancel",
            style: AppStyles.styleRegular16(
              context,
            ).copyWith(color: AppColor.white),
          ),
        ),
        TextButton(
          onPressed: () {
            final number = int.tryParse(_controller.text) ?? 10;
            Navigator.of(context).pop(number);
          },
          style: TextButton.styleFrom(
            backgroundColor: AppColor.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.search, color: AppColor.white, size: 20),
              const SizedBox(width: 8),
              Text(
                "Search",
                style: AppStyles.styleRegular16(
                  context,
                ).copyWith(color: AppColor.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
