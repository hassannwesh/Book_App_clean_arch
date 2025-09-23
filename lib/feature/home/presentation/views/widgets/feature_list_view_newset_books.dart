import 'dart:math';
import 'package:bookly_app/core/utils/widgets/custom_loading_indicator.dart';
import 'package:bookly_app/feature/home/presentation/manger/featued_books/newest_books_cubit/newest_books_cubit.dart';
import 'package:bookly_app/feature/home/presentation/views/widgets/newset_books_list_view_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeatureListViewNewsetBooks extends StatelessWidget {
  const FeatureListViewNewsetBooks({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewestBooksCubit, NewestBooksStates>(
      builder: (context, state) {
        if (state is NewestBooksSuccess) {
          return Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: state.books.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: CustomBookListViewItem(bookModel: state.books[index]),
                );
              },
            ),
          );
        } else if (state is NewestBooksFailure) {
          return Text(state.errMessage);
        } else {
          return const CustomLoadingindicator();
        }
      },
    );
  }
}
