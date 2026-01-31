import 'package:dio/dio.dart';
import 'package:newsify_app/feature/home/data/model/model.dart';

class DioClient {
  final Dio dio = Dio();
  Future<List<Article>?> getNews(String sort) async {
    try {
    final Response response = await dio.get(
      "https://newsapi.org/v2/everything?q=apple&from=2026-01-28&to=2026-01-28&sortBy=$sort&apiKey=0e236c83bd4d47188ed7737645f2106e",
      );
      if (response.statusCode == 200) {
        final data = NewsResponse.fromJson(response.data);
        final artList = data.articles;
        return artList;
      }else {
        print("Failed to load data: ${response.statusCode}");
      throw Exception("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      print("Failed to load data: $e");
      throw Exception("Failed to load data: $e");
    }
  }
}