import 'package:flutter/material.dart';

import 'flutter_widgets.dart';
import 'skee_button.dart';

class WeBottomSheet {
  static Future show(
    BuildContext context, {
    required Widget content,
    Widget? trailing,
    bool enableDrag = true,
    bool floatted = false,
    bool fullHeight = false,
    double borderRadius = 25,
    Color? barrierColor,
    bool showLeading = false,
    String? leadingLabel,
    Function? leadingAction,
  }) async {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      isScrollControlled: true,
      enableDrag: enableDrag,
      builder: (context) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: Colors.white,
          ),
          margin: EdgeInsets.fromLTRB(
            floatted ? 10 : 0,
            0,
            floatted ? 10 : 0,
            floatted ? 24 : 0,
          ),
          child: SizedBox(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 60,
                  child: Stack(
                    children: [
                      if (showLeading) WeButtons.text(leadingLabel!, ontap: () => leadingAction),
                      Align(
                        alignment: Alignment.topCenter,
                        child: _swipeIndicator,
                      ),
                      Positioned(
                        right: 20,
                        top: 15,
                        child: InkWell(
                          onTap: () => Navigator.of(context).pop(),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.close,
                                size: 15,
                                color: Colors.grey,
                              ),
                              WEText.custom(
                                'close',
                                fontsize: 12,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  constraints: BoxConstraints(
                    maxHeight: fullHeight ? MediaQuery.of(context).size.height * 0.8 : 300,
                  ),
                  child: content,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Container get _swipeIndicator => Container(
      height: 5.0,
      width: 80.0,
      margin: const EdgeInsets.only(
        top: 16.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.black26,
      ),
    );

//  margin: EdgeInsets.fromLTRB(
//             floatted ? 10.0 : 0.0,
//             0.0,
//             floatted ? 10.0 : 0.0,ed
//             floatted ? 24.0 : 0,
//           ),

//  required Widget content,
//     Widget? trailing,
//     bool enableDrag = true,
//     bool floatted = false,
//     bool fullHeight = false,
//     bool hideHead = false,
//     double borderRadius = 35,
//     Color? b
      // context: context,
      // backgroundColor: Colors.transparent,
      // isDismissible: true,
      // isScrollControlled: true,
      // enableDrag: enableDrag,