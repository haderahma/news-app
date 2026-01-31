import 'package:flutter/material.dart';
import 'package:newsify_app/feature/home/data/model/model.dart';

class DetalScreen extends StatelessWidget {
  const DetalScreen({super.key, required this.article});
  final Article article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("News Detail",
        style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
           Image.network(article.urlToImage ?? "",
           height: 300,width: MediaQuery.of(context).size.width,),
                Text(article.title ?? "",
                style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
                const SizedBox(height: 10,),

                 Text(article.description ?? "",),
                 Text(article.content ?? ""),
        ],),
      ),
    );
  }
}