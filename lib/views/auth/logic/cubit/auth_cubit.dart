import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:our_store/views/auth/logic/cubit/auth_cubit_state.dart';
import 'package:our_store/views/auth/logic/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:google_sign_in/google_sign_in.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  AuthCubit() : super(AuthCubitInitial());
  SupabaseClient client = Supabase.instance.client;
  UserModel? userModel;

  Future<void> login({required String email, required String password}) async {
    emit(LoadingLogin());
    try {
      await client.auth.signInWithPassword(email: email, password: password);
      emit(SuccessLogin());
    } on AuthException catch (e) {
      emit(FailureLogin(message: e.toString()));
    } catch (e) {
      emit(FailureLogin(message: e.toString()));
    }
  }

  Future<void> signUp({
    required String email,
    required String name,
    required String password,
  }) async {
    emit(LoadingSignUp());
    try {
      await client.auth.signUp(email: email, password: password);
      await addUserData(name: name, email: email);
      emit(SuccessSignUp());
    } on AuthException catch (e) {
      emit(FailureSignUp(message: e.toString()));
    } catch (e) {
      emit(FailureSignUp(message: e.toString()));
    }
  }

  Future<void> sendEmail({required String email}) async {
    emit(LoadingEmailSent());
    try {
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
    emit(LoadingUpdating());
    try {
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
    emit(LoadingUpdating());
    try {
      await client.auth.updateUser(UserAttributes(password: password));
      emit(SuccessUpdating());
    } catch (e) {
      emit(FailureUpdating(message: e.toString()));
    }
  }

  Future<void> addUserData({
    required String name,
    required String email,
  }) async {
    emit(LoadingUserDataAdded());
    try {
      await client.from('users').insert({
        'id': client.auth.currentUser!.id,
        'name': name,
        'email': email,
      });
      emit(SuccessUserDataAdded());
    } catch (e) {
      emit(FailureUserDataAdded(message: e.toString()));
    }
  }

  Future<void> getUserData() async {
    emit(LoadingUserDataGot());
    try {
      final response = await client
          .from('users')
          .select()
          .eq('id', client.auth.currentUser!.id);
      userModel = UserModel.fromJson(response);
      emit(SuccessUserDataGot());
    } catch (e) {
      emit(FailureUserDataGot(message: e.toString()));
    }
  }

  Future<void> logOut() async {
    emit(LoadingLogout());
    try {
      await client.auth.signOut();
      emit(SuccessLogout());
    } catch (e) {
      emit(FailureLogout(message: e.toString()));
    }
  }
}
