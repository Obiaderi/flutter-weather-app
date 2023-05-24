import 'package:flutter/material.dart';

class GlobalBottomSheet {
  static void customShowModelBottomSheet({
    required BuildContext context,
    required Widget widget,
    bool? canDismiss,
  }) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      isScrollControlled: true,
      isDismissible: canDismiss ?? true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (BuildContext bc) {
        return widget;
      },
    );
  }
}
