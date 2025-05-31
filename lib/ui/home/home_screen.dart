import 'package:admin_v4/core/auth/auth_notifier.dart';
import 'package:admin_v4/core/notifiers/constant_notifiers.dart';
import 'package:admin_v4/core/pocketbase/education_details_notifier.dart';
import 'package:admin_v4/core/pocketbase/personal_info_notifier.dart';
import 'package:admin_v4/models/education_details.dart';
import 'package:admin_v4/models/personal_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String loggedInUserName = ref.read(authNotifierProvider.notifier).userName;
    final AsyncValue<PersonalInfo?> personalInfoData = ref.watch(
      personalInfoProvider,
    );
    final AsyncValue<EducationDetails?> educationDetailsData = ref.watch(
      educationDetailsProvider,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, $loggedInUserName'),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(authNotifierProvider.notifier).logout();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: ListView(
        children: [
          

          ...[
            switch (personalInfoData) {
              AsyncData(:final value) => Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  leading: CircleAvatar(backgroundImage: NetworkImage(ref.read(imageUrlProvider(collectionId: value?.items.first.collectionId ?? '', id: value?.items.first.id ?? '', field: value?.items.first.avatar ?? '')))),
                  title: Text('Personal Info'),
                  subtitle: Text(
                    '${value?.items.first.name ?? ''}, ${value?.items.first.address ?? ''}, ${value?.items.first.phoneNumber ?? ''}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_forward_ios),
                  ),
                ),
              ),
              AsyncError(:final error) => Text(error.toString()),
              AsyncLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
              _ => const SizedBox.shrink(),
            },
          ],
          ...[
            switch (personalInfoData) {
              AsyncData(:final value) => Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text('Personal Info'),
                  subtitle: Text(
                    '${value?.items.first.name ?? ''}, ${value?.items.first.address ?? ''}, ${value?.items.first.phoneNumber ?? ''}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_forward_ios),
                  ),
                ),
              ),
              AsyncError(:final error) => Text(error.toString()),
              AsyncLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
              _ => const SizedBox.shrink(),
            },
          ],
          ...[
            switch (educationDetailsData) {
              AsyncData(:final value) => Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text('Education Details'),
                  subtitle: Text('${value?.items.first.institute ?? ''} ${value?.items.first.city ?? ''}', maxLines: 1, overflow: TextOverflow.ellipsis,),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_forward_ios),
                  ),
                ),
              ),
              AsyncError(:final error) => Text(error.toString()),
              AsyncLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
              _ => const SizedBox.shrink(),
            },
          ],
        ],
      ),
    );
  }
}
