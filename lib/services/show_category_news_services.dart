
import 'dart:convert';

import '../models/show_category_news_model.dart';
import 'package:http/http.dart' as http;

class ShowCategoryNewsServices{

  List<ShowCategoryNewsModel> categories = [];

  Future<void> getCategories(String category) async{
    String url = 'https://newsapi.org/v2/everything?q=$category&apiKey=3bcadf896a604f01a5a65bb557528316';
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    if(jsonData['status']=='ok'){
      jsonData['articles'].forEach((element){
        if(element['urlToImage'] !=null && element['description'] !=null){
          ShowCategoryNewsModel showCategoryNewsModel = ShowCategoryNewsModel(
            title: element['title'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element['content'],
            author: element['author'],
          );
          categories.add(showCategoryNewsModel);
        }
      });
    }
  }
}