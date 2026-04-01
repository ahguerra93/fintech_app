class ProfileData {
  final String name;
  final String email;
  final String accountId;

  const ProfileData({required this.name, required this.email, required this.accountId});

  ProfileData copyWith({String? name, String? email, String? accountId}) {
    return ProfileData(name: name ?? this.name, email: email ?? this.email, accountId: accountId ?? this.accountId);
  }
}
