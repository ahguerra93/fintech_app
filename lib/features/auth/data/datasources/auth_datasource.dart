abstract class AuthDataSource {
  Future<bool> login(String email, String password);
}

class AuthDataSourceImpl implements AuthDataSource {
  @override
  Future<bool> login(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    // Dummy logic: any email/password is accepted
    return true;
  }
}
