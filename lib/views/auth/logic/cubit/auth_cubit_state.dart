abstract class AuthCubitState {}

final class AuthCubitInitial extends AuthCubitState {}

final class Success extends AuthCubitState {}
final class Failure extends AuthCubitState {
  final String message;

  Failure({required this.message});
}
final class Loading extends AuthCubitState {}

// final class SuccessSignUp extends AuthCubitState {}
// final class FailureSignUp extends AuthCubitState {}