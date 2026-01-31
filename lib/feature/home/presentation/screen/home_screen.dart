import 'package:flutter/material.dart';
import 'package:newsify_app/core/API/dio.dart';
import 'package:newsify_app/core/localization/app_string.dart';
import 'package:newsify_app/feature/home/data/model/model.dart';
import 'package:newsify_app/feature/home/presentation/screen/detal_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DioClient dioClient = DioClient();
  int selectedIndex = 0;
  List<Article> articles = [];
  @override
  void initState() {
   dioClient.getNews("all").then((value){
   setState(() {
     articles = value!;
   });
   });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      articles.isEmpty 
      ? const Center(child: CircularProgressIndicator(),) 
      : CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
           title: Text(AppString.appName,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppString.breakingNews,style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                  SizedBox(height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                     itemCount: articles.length,
                     itemBuilder: (BuildContext context, int index) { 
                     return InkWell(onTap: () {
                       Navigator.push(context, MaterialPageRoute(builder: (context)=> DetalScreen(article: articles[index])));
                     },
                       child: Card( color: Colors.blue,
                        child: Image.network(articles[index].urlToImage ?? ""),
                       ),
                     );
                     },
                  ),
                            ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: AppString.newsCategories.length,
                itemBuilder: (BuildContext context, int index) {  
                  return InkWell(onTap: () {
                    setState(() { 
                      selectedIndex = index;
                      articles.clear();
                      dioClient.getNews(AppString.newsCategories[index]).then((value){
                        setState(() {
                          articles = value!;
                        });
                      });
                      
                    });
                  },
                    child: Card(
                      color: selectedIndex == index 
                      ? Colors.blue
                      : Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(AppString.newsCategories[index],style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                      ),
                    ),
                  );
                },),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text(AppString.newsForYou,style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                
                SizedBox(width: MediaQuery.of(context).size.width,
                height: 800,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: articles.length,
                    itemBuilder: (BuildContext context, int index) { 
                      return Row(children: [
                         Card(color: Colors.blue,
                          child: Image.network(articles[index].urlToImage ?? '',width: 150,height: 150,fit: BoxFit.cover,)),
                         const SizedBox(width: 10,),
                         Expanded(
                           child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Text(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            articles[index].title ?? ''),
                            const SizedBox(height: 10,),
                                                   Text(
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            articles[index].description ?? ''),
                           ],),
                         )
                      
                      ],
                      );
                     },),
                )
              ],),
            ),
          )
        ],
       
      ),
    );
  }
}