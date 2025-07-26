abstract class AuthCubitState {}

final class AuthCubitInitial extends AuthCubitState {}
final class SuccessLogin extends AuthCubitState {}
final class FailureLogin extends AuthCubitState {
  final String message;

  FailureLogin({required this.message});
}
final class LoadingLogin extends AuthCubitState {}





final class SuccessSignUp extends AuthCubitState {}
final class FailureSignUp extends AuthCubitState {
  final String message;

  FailureSignUp({required this.message});
}
final class LoadingSignUp extends AuthCubitState {}


final class SuccessEmailSent extends AuthCubitState {}
final class FailureEmailSent extends AuthCubitState {
  final String message;

  FailureEmailSent({required this.message});
}
final class LoadingEmailSent extends AuthCubitState {}


final class SuccessVerfying extends AuthCubitState {}
final class FailureVerfying extends AuthCubitState {
  final String message;

  FailureVerfying({required this.message});
}
final class LoadingVerfying extends AuthCubitState {}


final class SuccessUpdating extends AuthCubitState {}
final class FailureUpdating extends AuthCubitState {
  final String message;

  FailureUpdating({required this.message});
}
final class LoadingUpdating extends AuthCubitState {}




final class SuccessLogout extends AuthCubitState {}
final class FailureLogout extends AuthCubitState {
  final String message;

  FailureLogout({required this.message});
}
final class LoadingLogout extends AuthCubitState {}