import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mychatgpt/models/models_model.dart';
import 'package:mychatgpt/providers/models_provider.dart';
import 'package:mychatgpt/utils/app_colors.dart';
import 'package:mychatgpt/widgets/text_widget.dart';
import 'package:provider/provider.dart';


class ModelsDropDownWidget extends StatefulWidget {
  const ModelsDropDownWidget({super.key});

  @override
  State<ModelsDropDownWidget> createState() => _ModelsDropDownWidgetState();
}

class _ModelsDropDownWidgetState extends State<ModelsDropDownWidget> {
  String? currentModel;

  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(context, listen: false);
    currentModel = modelsProvider.getCurrentModel;

    return ListView.builder(
        itemCount: modelsProvider.getModelsList.length,
        itemBuilder: (context, index) {
          return modelsProvider.getModelsList.isEmpty
              ? const SizedBox.shrink()
              : FittedBox(
            child: DropdownButton(
              dropdownColor: scaffoldBackgroundColor,
              iconEnabledColor: Colors.white,
              items: List<DropdownMenuItem<String>>.generate(
                modelsProvider.getModelsList.length,
                    (index) => DropdownMenuItem(
                  value: modelsProvider.getModelsList[index].id,
                  child: TextWidget(
                    label: modelsProvider.getModelsList[index].id,
                    fontSize: 15,
                  ),
                ),
              ),
              value: currentModel,
              onChanged: (value) {
                setState(() {
                  currentModel = value.toString();
                });
                modelsProvider.setCurrentModel(value.toString());
              },
            ),
          );
        },
    );

    // return FutureBuilder<List<ModelsModel>>(
    //     future: modelsProvider.getModelsList(),
    //     builder: (context, snapshot) {
    //       if (snapshot.hasError) {
    //         return Center(
    //           child: TextWidget(label: snapshot.error.toString(),
    //           ),
    //         );
    //       }
    //       return snapshot.data == null || snapshot.data!.isEmpty
    //           ? const SizedBox.shrink()
    //           : FittedBox(
    //               child: DropdownButton(
    //                   dropdownColor: scaffoldBackgroundColor,
    //                   iconEnabledColor: Colors.white,
    //                   items: List<DropdownMenuItem<String>>.generate(
    //                       snapshot.data!.length,
    //                       (index) => DropdownMenuItem(
    //                           value: snapshot.data![index].id,
    //                           child: TextWidget(
    //                             label: snapshot.data![index].id,
    //                             fontSize: 15,
    //                           ),
    //                       ),
    //                   ),
    //                   value: currentModel,
    //                   onChanged: (value) {
    //                     setState(() {
    //                       currentModel = value.toString();
    //                     });
    //                     modelsProvider.setCurrentModel(value.toString());
    //                   },
    //               ),
    //           );
    //     },
    // );
  }
}
