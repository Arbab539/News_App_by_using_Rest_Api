import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news/widgets/view_all_section.dart';

import '../models/article_news_model.dart';
import '../models/slider_model.dart';
import '../services/article_news_services.dart';
import '../services/slider_services.dart';

class ViewAllScreen extends StatefulWidget {
  String news;
  ViewAllScreen({super.key,required this.news});

  @override
  State<ViewAllScreen> createState() => _ViewAllScreenState();
}

class _ViewAllScreenState extends State<ViewAllScreen> {

  List<SliderModel> sliders = [];
  List<ArticleNewsModel> articles = [];
  bool isLoading = true;


  @override
  void initState() {
    // TODO: implement initState
    getSliders();
    getNews();
    super.initState();
  }
  getSliders() async{
    Sliders newSliders = Sliders();
    await newSliders.getSliders();
    sliders = newSliders.sliders;
    setState(() {
      isLoading = false;
    });
  }
  getNews() async{
    News newNews = News();
    await newNews.getNews();
    articles = newNews.news;
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          '${widget.news} News',
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: isLoading
          ?
      const Center(
        child: SpinKitCircle(
          color: Colors.blue, // You can customize the color
          size: 50.0, // You can customize the size
        ),
      )
          :
      ListView.builder(
          itemCount: widget.news == 'Breaking'?sliders.length:articles.length,
          itemBuilder: (context,index){
            return ViewAllSection(
                image: widget.news == 'Breaking'?sliders[index].urlToImage!:articles[index].urlToImage!,
                name: widget.news == 'Breaking'?sliders[index].title!:articles[index].title!,
                desc: widget.news == 'Breaking'?sliders[index].description!:articles[index].description!,
                url: widget.news == 'Breaking'?sliders[index].url!:articles[index].url!,
            );
          }
      ),
    );
  }
}
