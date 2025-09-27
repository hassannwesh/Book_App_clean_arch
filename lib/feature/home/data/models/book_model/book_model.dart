import 'dart:convert';

import 'package:bookly_app/feature/home/domain/entities/book_entity.dart';
import 'package:equatable/equatable.dart';

import 'access_info.dart';
import 'sale_info.dart';
import 'search_info.dart';
import 'volume_info.dart';

class BookModel extends BookEntity {
  final String? kind;
  final String? id;
  final String? etag;
  final String? selfLink;
  final VolumeInfo volumeInfo;
  final SaleInfo? saleInfo;
  final AccessInfo? accessInfo;
  final SearchInfo? searchInfo;

  BookModel({
    this.kind,
    this.id,
    this.etag,
    this.selfLink,
    required this.volumeInfo,
    this.saleInfo,
    this.accessInfo,
    this.searchInfo,
  }) : super(
         bookId: id!,
         image: volumeInfo.imageLinks?.thumbnail ?? '',
         title: volumeInfo.title!,
         authorName: volumeInfo.authors?.first??'no aother',
         price: 0.0,
         rating: 345,
       );

  factory BookModel.fromMap(Map<String, dynamic> data) {
    // التحقق من وجود volumeInfo قبل إنشاء BookModel
    if (data['volumeInfo'] == null) {
      throw Exception('volumeInfo is required but was null');
    }

    return BookModel(
      kind: data['kind'] as String?,
      id: data['id'] as String?,
      etag: data['etag'] as String?,
      selfLink: data['selfLink'] as String?,
      volumeInfo: VolumeInfo.fromMap(
        data['volumeInfo'] as Map<String, dynamic>,
      ),
      saleInfo: data['saleInfo'] == null
          ? null
          : SaleInfo.fromMap(data['saleInfo'] as Map<String, dynamic>),
      accessInfo: data['accessInfo'] == null
          ? null
          : AccessInfo.fromMap(data['accessInfo'] as Map<String, dynamic>),
      searchInfo: data['searchInfo'] == null
          ? null
          : SearchInfo.fromMap(data['searchInfo'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() => {
    'kind': kind,
    'id': id,
    'etag': etag,
    'selfLink': selfLink,
    'volumeInfo': volumeInfo.toMap(),
    'saleInfo': saleInfo?.toMap(),
    'accessInfo': accessInfo?.toMap(),
    'searchInfo': searchInfo?.toMap(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [BookModel].
  factory BookModel.fromJson(String data) {
    return BookModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [BookModel] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props {
    return [
      kind,
      id,
      etag,
      selfLink,
      volumeInfo,
      saleInfo,
      accessInfo,
      searchInfo,
    ];
  }
}
