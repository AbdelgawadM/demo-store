import 'package:bloc/bloc.dart';
import 'package:our_store/views/auth/logic/cubit/auth_cubit_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  AuthCubit() : super(AuthCubitInitial());
  SupabaseClient client = Supabase.instance.client;

  Future<void> login({required String email, required String password}) async {
    try {
      emit(Loading());
      await client.auth.signInWithPassword(email: email, password: password);
      emit(Success());
    } on AuthException catch (e) {
      emit(Failure(message: e.toString()));
    } catch (e) {
      emit(Failure(message: e.toString()));
    }
  }
}
