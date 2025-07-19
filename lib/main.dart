import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_store/core/app_colors.dart';
import 'package:our_store/secret_constants.dart';
import 'package:our_store/views/auth/logic/cubit/auth_cubit.dart';
import 'package:our_store/views/auth/ui/forget_view.dart';
import 'package:our_store/views/auth/ui/login_view.dart';
import 'package:our_store/views/auth/ui/sign_up_view.dart';
import 'package:our_store/views/main_home_view/ui/main_home_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: url, anonKey: apiKey);
  runApp(const DemoStore());
}

class DemoStore extends StatelessWidget {
  const DemoStore({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Demo Store',
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.kScaffoldColor,
          appBarTheme: AppBarTheme(
            // color: AppColors.kPrimaryColor,
            centerTitle: true,
            backgroundColor: AppColors.kPrimaryColor,
            foregroundColor: AppColors.kWhiteColor,
          ),
        ),
        home: MainHomeView(),
      ),
    );
  }
}
