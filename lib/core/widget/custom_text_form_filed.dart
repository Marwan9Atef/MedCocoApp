import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../theme/app_color.dart';
import '../theme/app_style.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.textInputType,
    required this.hintText,
    this.controller,
    this.prefixIconPath,
    this.validator,
    this.isPassword = false,
    this.onChanged,
    this.onSaved,
    this.maxLines = 1,
    this.autofillHints,
  });

  final TextEditingController? controller;
  final TextInputType textInputType;
  final String? prefixIconPath;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final bool isPassword;
  final int maxLines;
  final String hintText;
  final Iterable<String>? autofillHints;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool isObscure = widget.isPassword;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      onChanged: widget.onChanged,
      onSaved: widget.onSaved,
      keyboardType: widget.textInputType,
      maxLines: widget.maxLines,
      obscureText: isObscure,
      autofillHints: widget.autofillHints,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      cursorColor: AppColor.primaryColor,
      style: AppStyles.styleRegular16(context).copyWith(
        color: AppColor.white,
      ),
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFF09090B),
        hintText: widget.hintText,
        hintStyle: AppStyles.styleRegular14(context),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 12,
        ),

        prefixIcon: widget.prefixIconPath != null
            ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SvgPicture.asset(
            widget.prefixIconPath!,
            width: 22,
            height: 22,
            fit: BoxFit.scaleDown,
            colorFilter: ColorFilter.mode(AppColor.gray, BlendMode.srcIn),
          ),
        )
            : null,

        prefixIconConstraints: const BoxConstraints(
          minWidth: 40,
          minHeight: 40,
        ),
        suffixIcon: widget.isPassword


            ? IconButton(
          onPressed: () {
            setState(() {
              isObscure = !isObscure;
            });
          },
          icon: Icon(color: AppColor.white,
            isObscure
                ? CupertinoIcons.eye
                : CupertinoIcons.eye_slash,

          ),
        )
            : null,

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: AppColor.gray.withValues(alpha: 0.4),
            width: 1,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: AppColor.primaryColor,
            width: 1.2,
          ),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: AppColor.red,
          ),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: AppColor.red,
          ),
        ),
      ),
    );
  }
}
