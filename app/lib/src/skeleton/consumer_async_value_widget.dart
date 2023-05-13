import 'package:flutter/material.dart'
    show BuildContext, Center, CircularProgressIndicator, Key, Text, Widget;
import 'package:hooks_riverpod/hooks_riverpod.dart';

typedef BuildWithData<T> = Widget Function(
    BuildContext context, WidgetRef ref, T data);

class ConsumerAsyncValueWidget<T> extends ConsumerWidget {
  final AsyncValue<T> asyncValue;
  final BuildWithData<T> buildWithData;

  const ConsumerAsyncValueWidget(
      {Key? key, required this.asyncValue, required this.buildWithData})
      : super(key: key);

  /// The build method that is called when the data is not available.
  /// The error is passed as a parameter.
  Widget buildWithError(BuildContext context, WidgetRef ref, Object error) {
    return Center(
      child: Text(
        "Error while loading data: ${error.toString()}",
      ),
    );
  }

  /// The build method that is called when the data is not available.
  Widget buildWhileLoading(BuildContext context, WidgetRef ref) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (asyncValue.isLoading) {
      return buildWhileLoading(context, ref);
    } else if (asyncValue.error != null) {
      return buildWithError(context, ref, asyncValue.error!);
    } else {
      return buildWithData(context, ref, asyncValue.asData!.value);
    }
  }
}
