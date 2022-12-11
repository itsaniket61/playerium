import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SearchScreenController extends GetxController {
  var searchedItems = [].obs;
  var textInputController = TextEditingController().obs;

  getSearch(txt) async {
    try {
      var res = await http.get(Uri.parse(
          "https://playerium.itsaniket61.repl.co/search?q=${txt}&page=1"));
      if (res.statusCode == 200) {
        searchedItems.value = jsonDecode(res.body);
        searchedItems.refresh();
      }
    } catch (e) {
      searchedItems.value = ['xx'];
      refresh();
    }
  }
}
