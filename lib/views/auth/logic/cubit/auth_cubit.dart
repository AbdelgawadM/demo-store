import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:our_store/views/auth/logic/cubit/auth_cubit_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:google_sign_in/google_sign_in.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  AuthCubit() : super(AuthCubitInitial());
  SupabaseClient client = Supabase.instance.client;

  Future<void> login({required String email, required String password}) async {
    try {
      emit(LoadingLogin());
      await client.auth.signInWithPassword(email: email, password: password);
      emit(SuccessLogin());
    } on AuthException catch (e) {
      emit(FailureLogin(message: e.toString()));
    } catch (e) {
      emit(FailureLogin(message: e.toString()));
    }
  }

  Future<void> signUp({required String email, required String password}) async {
    try {
      emit(LoadingSignUp());
      await client.auth.signUp(email: email, password: password);
      emit(SuccessSignUp());
    } on AuthException catch (e) {
      emit(FailureSignUp(message: e.toString()));
    } catch (e) {
      emit(FailureSignUp(message: e.toString()));
    }
  }

  Future<void> sendEmail({required String email}) async {
    try {
      emit(LoadingEmailSent());
      await client.auth.resetPasswordForEmail(
        email,
        redirectTo: 'ourstore://reset-password',
      );
      emit(SuccessEmailSent());
    } catch (e) {
      emit(FailureEmailSent(message: e.toString()));
    }
  }

  Future<void> verifyOTP({
    required String email,
    required String otpCode,
  }) async {
    try {
      emit(LoadingUpdating());
      final session = await client.auth.verifyOTP(
        type: OtpType.recovery,
        email: email,
        token: otpCode,
      );

      if (session.user != null) {
        // Success! User is now signed in temporarily
        // Navigate to a "Reset Password" screen
        emit(SuccessVerfying());
      }
    } catch (e) {
      emit(FailureVerfying(message: e.toString()));
    }
  }

  Future<void> updatePassword(String password) async {
    try {
      emit(LoadingUpdating());
      await client.auth.updateUser(UserAttributes(password: password));
    } catch (e) {
      emit(FailureUpdating(message: e.toString()));
    }
    emit(SuccessUpdating());
  }

  Future<void> logOut() async {
    try {
      emit(LoadingLogout());
      await client.auth.signOut();
    } catch (e) {
      emit(FailureLogout(message: e.toString()));
    }
    emit(SuccessLogout());
  }
}
