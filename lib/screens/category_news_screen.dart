
import 'package:flutter/material.dart';
import 'package:news/models/show_category_news_model.dart';
import 'package:news/services/show_category_news_services.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../widgets/show_category.dart';

class CategoryNews extends StatefulWidget {
  String name;
  CategoryNews({super.key, required this.name});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ShowCategoryNewsModel> categories = [];
  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    getCategoryNews();
    super.initState();
  }

  getCategoryNews() async {
    ShowCategoryNewsServices showCategoryNewsServices = ShowCategoryNewsServices();
    await showCategoryNewsServices.getCategories(widget.name.toLowerCase());
    categories = showCategoryNewsServices.categories;
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
          style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: loading
          ? const Center(
        child: SpinKitCircle(
          color: Colors.blue, // You can customize the color
          size: 50.0, // You can customize the size
        ),
      )
          : Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return ShowCategory(
              image: categories[index].urlToImage!,
              name: categories[index].title!,
              desc: categories[index].description!,
              url: categories[index].url!,
            );
          },
        ),
      ),
    );
  }
}

