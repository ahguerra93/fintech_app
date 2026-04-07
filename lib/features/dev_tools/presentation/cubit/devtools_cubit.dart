import 'package:fintech_app/features/dev_tools/presentation/cubit/devtools_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DevToolsCubit extends Cubit<DevToolsState> {
  DevToolsCubit() : super(const DevToolsState());

  void setResponseType(ResponseType responseType) {
    emit(state.copyWith(responseType: responseType));
  }
}
