import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_store/core/app_colors.dart';
import 'package:our_store/core/cubits/product_details_cubit/product_details_cubit.dart';
import 'package:our_store/secret_constants.dart';
import 'package:our_store/views/auth/logic/cubit/auth_cubit.dart';
import 'package:our_store/views/auth/ui/sign_up_view.dart';
import 'package:our_store/views/main_home_view/ui/main_home_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(url: url, anonKey: apiKey);
  // Bloc.observer = MyBlocObserver(); // Register it here

  // await SupabaseService().fetchProducts();
  runApp(const DemoStore());
}

class DemoStore extends StatefulWidget {
  const DemoStore({super.key});

  @override
  State<DemoStore> createState() => _DemoStoreState();
}

class _DemoStoreState extends State<DemoStore> {
  SupabaseClient client = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => ProductDetailsCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Demo Store',
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.kScaffoldColor,
          appBarTheme: const AppBarTheme(
            // color: AppColors.kPrimaryColor,
            centerTitle: true,
            backgroundColor: AppColors.kPrimaryColor,
            foregroundColor: AppColors.kWhiteColor,
          ),
        ),
        home: client.auth.currentUser == null ? SignUpView() : MainHomeView(),
      ),
    );
  }
}
