import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_resend_timer/otp_resend_timer.dart';
import 'package:valo/core/utils/app_snack_bars.dart';
import 'package:valo/feature/auth/presentation/cubit/forget/forget_cubit.dart';
import 'package:valo/feature/auth/presentation/cubit/forget/forget_states.dart';

import '../../../../../core/theme/app_style.dart';

class ResendButton extends StatefulWidget {
  const ResendButton({super.key, required this.email});
  final String email;

  @override
  State<ResendButton> createState() => _ResendButtonState();
}

class _ResendButtonState extends State<ResendButton> {
  final controller = OtpResendTimerController(initialTime: 30);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgetCubit, ForgetStates>(
      listener: (context, state) {
 if (state is ForgetSuccess) {
  AppSnackBars.showSuccessSnackBar(context: context, message: state.message);
 }else if (state is ForgetFailure) {
  AppSnackBars.showErrorSnackBar(context: context, message: state.error);
 }
      },
      child: OtpResendTimer(
        
        controller: controller,
        autoStart: true,
        timerMessageStyle: AppStyles.styleRegular14(context),
        readyMessageStyle: AppStyles.styleRegular14(context),
        timerMessage: "Resend OTP in ",
        readyMessage: "You can now resend the code",
        onFinish: () {},
        onResendClicked: () {
          
          context.read<ForgetCubit>().forget(widget.email);
        },
        onStart: () {},
      ),
    );
  }
}
