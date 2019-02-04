import 'dart:async';
import 'news_aoi_provider.dart';
import 'news_db.dart';
import '../models/item_model.dart';

class Repository {
  NewsDbProvider dbProvider = NewsDbProvider();
  NewsApiProvider apiProvider = NewsApiProvider();

  Future<List<int>> fetchTopIds() {
    return apiProvider.fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async{
    var item = await dbProvider.fetchItem(id);
    if(item != null) {
      return item;
    }

    item = await apiProvider.fetchItem(id);
    dbProvider.addItem(item);

    return item;
  }
}