import 'package:http/http.dart' as http;

abstract class NewsDataSource{
  Future<String> getNewsData();
}

class RemoteNewsDataSource implements NewsDataSource {
  @override
  Future<String> getNewsData() async{
    const apiKey = '4b397c0b925c48649a61b00c6ab69622';
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/everything?q=keyword&apiKey=$apiKey'));

    if(response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to get news data.');
    }
  }

}