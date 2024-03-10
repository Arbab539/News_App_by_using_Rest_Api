import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news/screens/article_news_screen.dart';

class BlogTile extends StatelessWidget {
  String image,title,desc,url;
  BlogTile({
    super.key,
    required this.image,
    required this.url,
    required this.title,
    required this.desc
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ArticleWebScreen(blogUrl: url)));
      },
      child: Container(
        margin: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
        child: Material(
          borderRadius: BorderRadius.circular(10),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 10),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: image,
                    height: 120,
                    width: 120,
                    fit: BoxFit.cover,
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
                const SizedBox(width: 8,),
                Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width/1.7,
                      child: Text(
                        title,
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width/1.7,
                      child: Text(
                        desc,
                        maxLines: 3,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
