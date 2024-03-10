
import 'dart:convert';

import '../models/article_news_model.dart';
import 'package:http/http.dart' as http;

class News{

  List<ArticleNewsModel> news  = [];

  Future<void> getNews()async{
    String url = 'https://newsapi.org/v2/everything?q=treading&apiKey=3bcadf896a604f01a5a65bb557528316';
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == 'ok'){
      jsonData['articles'].forEach((element){
        if(element['urlToImage'] !=null && element['description'] !=null){
          ArticleNewsModel articleNewsModel = ArticleNewsModel(
            title: element['title'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element['content'],
            author: element['author'],
          );
          news.add(articleNewsModel);
        }
      });
    }
  }
}