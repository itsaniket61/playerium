import 'dart:convert';
import 'package:json_cache/json_cache.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

class HomeScreenController extends GetxController {
  var data = [].obs;
  var titles = [].obs;
  getSections() async {
    data.value = [];
    refresh();
    try {
      var res = await http
          .get(Uri.parse("https://playerium.itsaniket61.repl.co/gdata"));
      if (res.statusCode == 200) {
        var li = jsonDecode(res.body);
        for (int i = 0; i < li.length; i++) {
          var r = await http.get(Uri.parse(
              "https://playerium.itsaniket61.repl.co/playlist?list=${li[i]}"));
          var d = jsonDecode(r.body);
          data.value.add(d);
          data.refresh();
        }
      }
      LocalStorage _storage = LocalStorage('my_data');
      JsonCache jsonCache = JsonCacheLocalStorage(_storage);
      await jsonCache.refresh('home_data', {'data': data});
    } catch (e) {
      data.value = ['xx'];
      refresh();
    }
  }

  _init() async {
    LocalStorage _storage = LocalStorage('my_data');
    JsonCache jsonCache = JsonCacheLocalStorage(_storage);
    final cachedInfo = await jsonCache.value('home_data');
    if (cachedInfo == null) {
      getSections();
    } else {
      data.value = cachedInfo['data'];
      refresh();
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _init();
  }
}
