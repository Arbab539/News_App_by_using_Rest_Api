import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:news/models/slider_model.dart';
import 'package:http/http.dart' as http;

class Sliders{

  List<SliderModel> sliders = [];

  Future<void> getSliders() async{
    String url = 'https://newsapi.org/v2/everything?q=breaking&apiKey=3bcadf896a604f01a5a65bb557528316';
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == 'ok'){
      jsonData['articles'].forEach((element){
        if(element['urlToImage'] !=null && element['description'] !=null){
          SliderModel sliderModel = SliderModel(
            title: element['title'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element['content'],
            author: element['author'],
          );
          sliders.add(sliderModel);
        }
      });
    }
  }
}