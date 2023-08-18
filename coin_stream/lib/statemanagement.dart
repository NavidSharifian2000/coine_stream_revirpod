import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart';

StreamController streamController = StreamController();
IO.Socket? socket;

class FruitsNotifier extends StateNotifier<fruitState> {
  FruitsNotifier() : super(fruitinitstate());
  void changestate() async {
    socket = IO.io(
        'https://api.wallex.ir/',
        OptionBuilder().setTransports(['websocket']) // for Flutter or Dart VM
            .build());
    socket!.connect();
    socket!.on("Broadcaster", (data) {
      print(data);
      streamController.add(data);
      state = fruitsuccess(streamController);
    });
    socket!.onConnect((data) {
      print("connected");
    });
    socket!.emit('subscribe', {"channel": "USDTTMN@trade"});
  }
}

//states
abstract class fruitState {}

class fruitinitstate extends fruitState {
  List<String>? miveha = ["nist"];
}

class fruitloadingstate extends fruitState {}

class fruitsuccess extends fruitState {
  StreamController streamController;
  fruitsuccess(this.streamController);
}

class SocketService {}
