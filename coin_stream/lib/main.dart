import 'dart:async';

import 'package:coin_stream/statemanagement.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  MyApp({super.key});
  final Coinprovider = StateNotifierProvider<FruitsNotifier, fruitState>((ref) {
    return FruitsNotifier();
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var data2 = ref.watch(Coinprovider);
    ref.read(Coinprovider.notifier).changestate();
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
            child: Column(
          children: [
            if (data2 is fruitsuccess) ...{
              StreamBuilder(
                  stream: data2.streamController.stream,
                  builder: ((context, snapshot) {
                    return Text(snapshot.data.toString());
                  })),
            },
            ElevatedButton(onPressed: () {}, child: Text("press"))
          ],
        )),
      ),
    );
  }
}
