import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news/screens/article_news_screen.dart';

// ignore: must_be_immutable
class ViewAllSection extends StatelessWidget {
  String name,image,desc,url;
  ViewAllSection({
    super.key,
    required this.image,
    required this.name,
    required this.desc,
    required this.url
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ArticleWebScreen(blogUrl: url)));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            ClipRRect(
             borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                  imageUrl: image,
                fit: BoxFit.cover,
                height: 200,
                width: MediaQuery.of(context).size.width,
                placeholder: (context,url)=> const Center(
                  child: SpinKitCircle(
                    color: Colors.blue, // You can customize the color
                    size: 50.0, // You can customize the size
                  ),
              ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey, // Default color for error
                  height: 120,
                  width: 120,
                  child: const Center(
                    child: Icon(
                      Icons.error_outline,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                ),
            ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              name,
              maxLines: 2,
              style: const TextStyle(
                fontSize:18,
                fontWeight: FontWeight.bold,
                color: Colors.black
              ),
            ),
            Text(
              desc,
              maxLines: 3,
              style: const TextStyle(

              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
