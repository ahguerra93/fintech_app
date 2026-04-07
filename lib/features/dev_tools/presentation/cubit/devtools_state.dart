import 'package:flutter/foundation.dart';

enum ResponseType { regular, error, empty }

@immutable
class DevToolsState {
  final ResponseType responseType;

  const DevToolsState({this.responseType = ResponseType.regular});

  DevToolsState copyWith({ResponseType? responseType}) {
    return DevToolsState(responseType: responseType ?? this.responseType);
  }
}
