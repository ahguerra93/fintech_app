import 'package:fintech_app/features/auth/data/datasources/auth_datasource.dart';
import 'package:fintech_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource dataSource;
  AuthRepositoryImpl({required this.dataSource});

  @override
  Future<bool> login(String email, String password) async {
    return await dataSource.login(email, password);
  }
}
