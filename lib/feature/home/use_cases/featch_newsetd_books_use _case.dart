import 'package:bookly_app/core/errors/failures.dart';
import 'package:bookly_app/core/use_cases/use_case.dart';
import 'package:bookly_app/feature/home/domain/book_entity.dart';
import 'package:bookly_app/feature/home/domain/repos/home_repo.dart';
import 'package:dartz/dartz.dart';

abstract class FeatchNewestdBooksUseCase extends UseCase<List<BookEntity>> {
  final HomeRepo homeRepo;
  FeatchNewestdBooksUseCase({required this.homeRepo});
  @override
  Future<Either<Failures, List<BookEntity>>> call() async {
    return await homeRepo.feachNewestBooks();
  }
}
