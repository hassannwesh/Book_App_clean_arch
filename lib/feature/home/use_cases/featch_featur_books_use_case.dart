import 'package:bookly_app/core/errors/failures.dart';
import 'package:bookly_app/feature/home/domain/book_entity.dart';
import 'package:bookly_app/feature/home/domain/repos/home_repo.dart';
import 'package:dartz/dartz.dart';

class FeatchFeaturBooksUseCase {
  final HomeRepo homeRepo;

  FeatchFeaturBooksUseCase({required this.homeRepo});
  Future<Either<Failures,List<BookEntity>>>featchFeaturedBooks(){
return homeRepo.feachFeaturedBooks();
  }

}
