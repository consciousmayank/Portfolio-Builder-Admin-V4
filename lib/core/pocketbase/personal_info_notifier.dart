import 'dart:convert';

import 'package:admin_v4/core/pocketbase/pocketbase_notifier.dart';
import 'package:admin_v4/models/personal_info.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'personal_info_notifier.g.dart';

@riverpod
Future<PersonalInfo?> personalInfo(Ref ref) async {
  final pb = ref.read(pocketbaseNotifierProvider);
  // final user = await pb.value?.collection('personal_details').getOne(pb.value?.authStore.record?.id ?? '', expand: 'soceial_media, userid');
  final user = await pb.value?.collection('personal_details').getList(
  page: 1,
  perPage: 1,
  expand: 'soceial_media, userid'
  // filter: 'userid = ${pb.value?.authStore.record?.id}',
);

  return user!=null ? personalInfoFromJson(jsonEncode(user)) : null;
}   