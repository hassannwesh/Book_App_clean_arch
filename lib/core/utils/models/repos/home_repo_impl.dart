import 'package:bookly_app/core/errors/failures.dart';
import 'package:bookly_app/core/utils/api_service.dart';
import 'package:bookly_app/core/utils/models/book_model/book_model.dart';
import 'package:bookly_app/core/utils/models/repos/home_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class HomeRepoImpl extends HomeRepo {
  ApiService apiService;
  HomeRepoImpl(this.apiService);

  @override
  Future<Either<Failures, List<BookModel>>> fetchFlutterNewsetBooks() async {
    try {
      var data = await apiService.get(
        endPoint:
            '/volumes?Filtering=free-ebooks&Sorting=newest&q=subject:health',
      );
      List<BookModel> books = [];
      for (var item in data['items']) {
        books.add(BookModel.fromMap(item));
      }
      return Right(books);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<BookModel>>> fetchFeaturedBooks() async {
    try {
      var data = await apiService.get(
        endPoint: '/volumes?Filtering=free-ebooks&q=subject:computer',
      );
      List<BookModel> books = [];
      for (var item in data['items']) {
        try {
          books.add(BookModel.fromMap(item));
        } catch (e) {
          // Handle or log the error for this specific item
          print('Error parsing book item: $e');
        }
      }
      return Right(books);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<BookModel>>> fetchSimilarBooks({
    required String category,
  }) async {
    try {
      var data = await apiService.get(
        endPoint:
            '/volumes?Filtering=free-ebooks&Sorting=newes&q=subject:computer',
      );
      List<BookModel> books = [];
      for (var item in data['items']) {
        try {
          books.add(BookModel.fromMap(item));
        } catch (e) {
          // Handle or log the error for this specific item
          print('Error parsing book item: $e');
        }
      }
      return Right(books);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<BookModel>>> searchBooks({
    required String query,
  }) async {
    try {
      var data = await apiService.get(
        endPoint:
            '/volumes?filter=free-ebooks&orderBy=relevance&q=${Uri.encodeComponent(query)}',
      );

      if (data['items'] == null) {
        return Right([]); // مفيش نتائج
      }

      List<BookModel> books = [];
      for (var item in data['items']) {
        try {
          // التحقق من وجود البيانات المطلوبة قبل إنشاء BookModel
          if (item is Map<String, dynamic> && item['volumeInfo'] != null) {
            books.add(BookModel.fromMap(item));
          } else {
            print('Skipping item with missing volumeInfo: $item');
          }
        } catch (e) {
          print('Error parsing book item: $e');
          print('Item data: $item');
        }
      }

      return Right(books);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
