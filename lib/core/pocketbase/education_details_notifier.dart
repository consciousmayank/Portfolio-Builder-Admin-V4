import 'dart:convert';

import 'package:admin_v4/core/pocketbase/pocketbase_notifier.dart';
import 'package:admin_v4/models/education_details.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'education_details_notifier.g.dart';

@riverpod
Future<EducationDetails?> educationDetails(Ref ref) async {
  final pb = ref.read(pocketbaseNotifierProvider);
  final user = await pb.value?.collection('education_details').getList(
  page: 1,
  perPage: 1,
);

  return user!=null ? educationDetailsFromJson(jsonEncode(user)) : null;
}   