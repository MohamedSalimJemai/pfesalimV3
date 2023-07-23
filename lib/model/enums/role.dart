import '../../utils/language/localization.dart';

enum Role {
  user("ROLE_USER"),
  admin("ROLE_ADMIN");

  final String value;

  const Role(this.value);
}

Role parseRole(String role) {
  switch (role) {
    case 'ROLE_USER':
      return Role.user;
    case 'ROLE_ADMIN':
      return Role.admin;
    default:
      throw ArgumentError('Unknown role: $role');
  }
}

extension StatusEnumLocalizationExtension on Role {
  String getLocalizedString() {
    switch (this) {
      case Role.user:
        return intl.user;
      case Role.admin:
        return intl.admin;
      default:
        throw Exception('Unknown audit status: $this');
    }
  }
}
