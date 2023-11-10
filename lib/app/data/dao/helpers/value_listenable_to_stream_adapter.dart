import 'dart:async';

import 'package:flutter/foundation.dart';

extension ValueListenableExtension<T> on ValueListenable<T> {
  Stream<T> toStream() {
    late StreamController<T> controller;

    void listener() {
      controller.add(value);
    }

    void start() {
      addListener(listener);
    }

    void end() {
      removeListener(listener);
    }

    controller = StreamController<T>(
      onListen: start,
      onPause: end,
      onResume: start,
      onCancel: end,
    );

    return controller.stream;
  }
}
