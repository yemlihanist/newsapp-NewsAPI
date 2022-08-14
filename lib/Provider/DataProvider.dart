import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../Constants/Constants.dart';
import '../Model/object.dart';

class DataProvider extends ChangeNotifier {
  List<Nesne> sonuclar = [];
  List<Nesne> favoriler = [];

  Future<void> getData(String search) async {
    sonuclar.clear();
    Uri url = Uri.parse(getUrl(search));
    var req = await get(url);
    var list = json.decode(req.body);

    (list['articles']).forEach((value) {
      sonuclar.add(Nesne.fromJson(value as Map));
    });
    print(sonuclar.length);
    notifyListeners();
  }

  List<Nesne> getQuery() {
    return sonuclar;
  }

  List<Nesne> getFavorite() {
    return favoriler;
  }

  void addFavorite(Nesne nesne) {
    favoriler.add(nesne);
    notifyListeners();
  }

  void removeFavorite(Nesne nesne) {
    favoriler.remove(nesne);
    notifyListeners();
  }

  bool isFavorite(Nesne nesne) {
    return favoriler.contains(nesne);
  }

  String getUrl(String aranan) {
    return Constants.host +
        "?q=" +
        aranan +
        "&page=1&apiKey=" +
        Constants.apiKey;
  }
}
