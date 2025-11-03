import 'package:bookly_app/core/utils/api_service.dart' show ApiService;
import 'package:bookly_app/core/utils/models/book_model/book_model.dart';
import 'package:bookly_app/feature/home/domain/entities/book_entity.dart';

abstract class HomeRemoteDataSource {
  Future<List<BookEntity>> fetchFeaturedBooks();
  Future<List<BookEntity>> fetchNewestBooks();
}

class HomeRemotDataSourcesImpl extends HomeRemoteDataSource {
  final ApiService apiService;

  HomeRemotDataSourcesImpl({ required this.apiService});
  @override
  Future<List<BookEntity>> fetchFeaturedBooks() async {
    var data = await apiService.get(endPoint: '/volumes?Filtering=free-ebooks&q=subject:computer');
    List<BookEntity> books = getBooksList(data);
    return books;
  }
  @override
  Future<List<BookEntity>> fetchNewestBooks()  async{
    var data = await apiService.get(endPoint:'/volumes?Filtering=free-ebooks&Sorting=newes&q=subject:computer',);
    List<BookEntity> books = getBooksList(data);
    return books;
  }

   List<BookEntity> getBooksList(Map<String, dynamic> data) {
     List<BookEntity> books = [];
    for (var bookMap in data['item']) {
      books.add(BookModel.fromJson(bookMap) as BookEntity);
    }
    return books;
  }
}


