import 'dart:core';

import 'package:flutter/material.dart';
import 'package:skeefiapp/app/widgets/we_buttons.dart';

Future WEModal(
  BuildContext context, {
  required Widget child,
  String? cancelText,
  Function? onConfirm,
  Function? onCancel,
  double? height,
  Widget? cancelWidget,
}) async {
  return showGeneralDialog(
      context: context,
      barrierLabel: 'Modal',
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.1),
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Material(
          type: MaterialType.transparency,
          borderRadius: BorderRadius.circular(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                height: height ?? 240,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    child,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // /
                        // / Cancel button

                        Flexible(
                          child: WeButtons.filled(
                            cancelText ?? 'Cancel',
                            height: 30,
                            width: 100,
                            fontsize: 13,
                            color: Colors.red,
                            ontap: () {
                              if (onCancel != null) {
                                onCancel();
                              }
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                        const SizedBox(width: 20),

                        // /
                        // / Confirm button
                        // /
                        if (onConfirm != null)
                          Flexible(
                            child: WeButtons.filled(
                              'Confirm',
                              height: 30,
                              width: 100,
                              fontsize: 13,
                              color: Colors.green,
                              ontap: () {
                                onConfirm();

                                Navigator.of(context).pop();
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
      });
}
