/// Kontrak abstrak untuk semua use case.
///
/// [Type] adalah return type, [Params] adalah parameter.
abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}

/// Digunakan saat use case tidak memerlukan parameter.
class NoParams {
  const NoParams();
}
