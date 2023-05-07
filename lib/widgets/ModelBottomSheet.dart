import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import './drop_down.dart';
import './text_widget.dart';

class Services {
  static Future<void> showModelBottomSheet({required BuildContext context}) async {
    await showModalBottomSheet(
      backgroundColor: scaffoldBackgroundColor,
      context: context,
      builder: (context) {
        return SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: const [
                Expanded(
                  flex: 1,
                  child: TextWidget(label: 'Chosen Model:', fontSize: 16),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 3,
                  child: ModelsDropDownWidget(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}