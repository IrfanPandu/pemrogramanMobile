import 'package:equatable/equatable.dart';

/// Base class untuk semua failure di aplikasi.
abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

/// Failure yang berasal dari database lokal.
class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message);
}

/// Failure untuk data tidak ditemukan.
class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message);
}

/// Failure umum / tidak terduga.
class UnexpectedFailure extends Failure {
  const UnexpectedFailure(super.message);
}
