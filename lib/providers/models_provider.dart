import 'package:flutter/material.dart';
import 'package:mychatgpt/services/api_services.dart';

import '../models/models_model.dart';

class ModelsProvider with ChangeNotifier {

  String currentModel = "text-davinci-003";
  String get getCurrentModel {
    return currentModel;
  }

  void setCurrentModel(String newModel) {
    currentModel = newModel;
    notifyListeners();
  }

  List<ModelsModel> modelsList = [];
  List<ModelsModel> get getModelsList {
    return modelsList;
  }

  void getAllModels() async {
    modelsList = await ApiServices.getModels();
    // return modelsList;
    notifyListeners();
  }

}