/// Lightweight reference to an AuthAccount (by UID).
/// No codegen required; tiny and stable across features.
class AuthAccountRef {
  final String id; // Firebase UID

  const AuthAccountRef(this.id);

  @override
  String toString() => 'AuthAccountRef($id)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AuthAccountRef && other.runtimeType == runtimeType && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
