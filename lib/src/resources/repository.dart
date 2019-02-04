import 'dart:async';
import 'news_aoi_provider.dart';
import 'news_db.dart';
import '../models/item_model.dart';

class Repository {
  List<Source> sources = <Source>[
    NewsDbProvider(),
    NewsApiProvider(),
  ];

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

abstract class Source{
  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchItem(int id);
}

abstract class Cache {
  Future<int> addItem(ItemModel im);
}