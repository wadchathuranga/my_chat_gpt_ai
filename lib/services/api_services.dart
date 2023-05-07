import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mychatgpt/models/chat_model.dart';

import '../models/models_model.dart';
import '../utils/app_configs.dart';

class ApiServices {
  // get type of models available
  static Future<List<ModelsModel>> getModels() async {
    try {
      var response = await http.get(
        Uri.parse("$BASE_URL/models"),
        headers: {
          "Authorization": "Bearer $OPENAI_API_KEY",
        }
      );

      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']['message']);
      }

      List temp = [];
      for (var value in jsonResponse['data']){
        temp.add(value);
        // print(value['id']);
      }

      return ModelsModel.modelsFromSnapshot(temp);
    } catch (error) {
      log("Error $error");
      rethrow;
    }
  }

  // send message
  static Future<List<ChatModel>> sendMessage({ required String message, required String modelId }) async {
    try {
      var response = await http.post(
          Uri.parse("$BASE_URL/completions"),
          headers: {
            "Authorization": "Bearer $OPENAI_API_KEY",
            "Content-Type": "application/json"
          },
        body: jsonEncode({
          "model": modelId,
          "prompt": message,
          "max_tokens": 100,
        }),
      );

      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']['message']);
      }

      List<ChatModel> chatList = [];
      if (jsonResponse["choices"].length > 0) {
        // log("jsonResponse['choices']['text'] ${jsonResponse["choices"][0]["text"]}");
        chatList = List.generate(
            jsonResponse["choices"].length,
            (index) => ChatModel(
              msg: jsonResponse["choices"][index]["text"],
              chatIndex: 1,
            ),
        );
      }
      return chatList;
      // return ModelsModel.modelsFromSnapshot(temp);
    } catch (error) {
      log("Error $error");
      rethrow;
    }
  }

  // Send Message using ChatGPT API
  static Future<List<ChatModel>> sendMessageGPT(
      {required String message, required String modelId}) async {
    try {
      log("modelId $modelId");
      var response = await http.post(
        Uri.parse("$BASE_URL/chat/completions"),
        headers: {
          'Authorization': 'Bearer $OPENAI_API_KEY',
          "Content-Type": "application/json"
        },
        body: jsonEncode(
          {
            "model": modelId,
            "messages": [
              {
                "role": "user",
                "content": message,
              }
            ]
          },
        ),
      );

      // Map jsonResponse = jsonDecode(response.body);
      Map jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      if (jsonResponse['error'] != null) {
        // print("jsonResponse['error'] ${jsonResponse['error']["message"]}");
        throw HttpException(jsonResponse['error']["message"]);
      }
      List<ChatModel> chatList = [];
      if (jsonResponse["choices"].length > 0) {
        // log("jsonResponse[choices]text ${jsonResponse["choices"][0]["text"]}");
        chatList = List.generate(
          jsonResponse["choices"].length,
              (index) => ChatModel(
            msg: jsonResponse["choices"][index]["message"]["content"],
            chatIndex: 1,
          ),
        );
      }
      return chatList;
    } catch (error) {
      log("error $error");
      rethrow;
    }
  }
}