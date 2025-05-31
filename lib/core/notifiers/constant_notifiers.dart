import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'constant_notifiers.g.dart';

@riverpod
String pocketBaseUrl(Ref ref) {
  return 'https://awspb.mayankjoshi.in';
}

@riverpod
String imageUrl (Ref ref, {required String collectionId, required String id, required String field}) {
  return '${ref.read(pocketBaseUrlProvider)}/api/files/$collectionId/$id/$field';
}
