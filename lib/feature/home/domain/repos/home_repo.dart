
import 'package:bookly_app/core/errors/failures.dart';
import 'package:bookly_app/feature/home/domain/entities/book_entity.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepo {
  Future<Either<Failures, List<BookEntity>>> feachFeaturedBooks();
  Future<Either<Failures, List<BookEntity>>> feachNewestBooks();
}
