import 'package:flutter/material.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/forgotbpassword/mail/forgetpasswordmail.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/forgotbpassword/option/fogetpasswordbt.dart';
import 'package:get/get.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/forgotbpassword/phone/forgetpaswordphone.dart';

class ForgetPasswordScreen {
  static Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ForgetPassword',
                style: Theme.of(context).textTheme.displayMedium),
            Text('Enter your email or phone number to reset your password',
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 30.0),
            ForgetPasswordBtnWidget(
              onTap: () {
                Get.to(PasswordResetEmailScreen());
              },
              title: 'Email Address',
              subTitle: 'Reset via Email Address',
              btnIcon: Icons.mail_outline_rounded,
            ),
            const SizedBox(height: 20.0),
            ForgetPasswordBtnWidget(
              onTap: () {
                Get.to(PasswordResetPhoneScreen());
              },
              title: 'Phone Number',
              subTitle: 'Reset via Phone Number',
              btnIcon: Icons.mobile_friendly_rounded,
            ),
          ],
        ),
      ),
    );
  }
}
