import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news/models/article_news_model.dart';
import 'package:news/models/slider_model.dart';
import 'package:news/screens/view_all_screen.dart';
import 'package:news/services/article_news_services.dart';
import 'package:news/services/category_news_data.dart';
import 'package:news/services/slider_services.dart';
import 'package:news/widgets/blog_tile.dart';
import 'package:news/widgets/category_tile.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../models/category_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<CategoryModel> categories = [];
  List<SliderModel> sliders = [];
  List<ArticleNewsModel> articles = [];
  bool isLoading = true;
  int activeIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    categories = getCategories();
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
        title: const Text(
          'News',
          style: TextStyle(
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
      SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 70,
              margin: const EdgeInsets.only(left: 10,right: 10),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context,index){
                    return CategoryTile(
                        image: categories[index].image,
                        title: categories[index].categoryName,
                    );
                  }
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0,right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Breaking News!',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAllScreen(news: 'Breaking')));
                    },
                    child:const Text(
                      'View All',
                      style:  TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CarouselSlider.builder(
              itemCount: 5,
              itemBuilder: (context, index, realIndex){
                String? res = sliders[index].urlToImage;
                String? res1 = sliders[index].title;
                return buildImage(res!, index,res1!);
              },
              options: CarouselOptions(
                  height: 250,
                  // viewportFraction: 1,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  onPageChanged: (index,reason){
                    setState(() {
                      activeIndex = index;
                    });
                  }
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: buildIndicator(),
            ),
            const SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.only(left: 10.0,right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Treading News!',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAllScreen(news: 'Treading')));
                    },
                    child:const Text(
                      'View All',
                      style:  TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: articles.length,
                itemBuilder: (context,index){
                  return BlogTile(
                      image: articles[index].urlToImage!,
                      url: articles[index].url!,
                      title: articles[index].title!,
                      desc: articles[index].description!
                  );
                }
            )
          ],
        ),
      ),
    );
  }
  Widget buildImage(String image, int index, String name) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: image,
              height: 250,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              placeholder: (context,url)=>const Center(
                child: SpinKitCircle(
                  size: 50,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          Container(
            height: 250,
            padding: const EdgeInsets.only(left: 10),
            margin: const EdgeInsets.only(top: 170),
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Text(
              name ?? '', // Perform null check and provide a default value
              maxLines: 2,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildIndicator()=>AnimatedSmoothIndicator(
    activeIndex: activeIndex,
    count: 5,
    effect: ScaleEffect(dotColor: Colors.blue,dotWidth: 12,dotHeight: 12),
  );

}
