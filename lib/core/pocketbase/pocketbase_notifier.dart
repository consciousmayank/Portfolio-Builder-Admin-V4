import 'package:admin_v4/core/notifiers/constant_notifiers.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pocketbase_notifier.g.dart';


@riverpod
class PocketbaseClient extends _$PocketbaseClient {

  @override
  PocketBase build() {
    return PocketBase(ref.read(pocketBaseUrlProvider));
  }
}

@Riverpod(keepAlive: true)
class PocketbaseNotifier extends _$PocketbaseNotifier {

  @override
  Future<PocketBase> build() async {
    final pb = ref.read(pocketbaseClientProvider);
    return pb;
  }
}