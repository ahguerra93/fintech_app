import 'package:equatable/equatable.dart';
import 'package:fintech_app/di/di.dart';
import 'package:fintech_app/features/auth/domain/usecases/login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  AuthBloc() : _loginUseCase = getIt<LoginUseCase>(), super(const Unauthorized()) {
    on<LoginRequested>(_onLoginRequested);
  }

  Future<void> _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      final success = await _loginUseCase(event.email, event.password);
      if (success) {
        emit(const Authorized());
      } else {
        emit(const Unauthorized());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
