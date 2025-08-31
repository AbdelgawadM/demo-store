import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_store/core/app_theme.dart';
import 'package:our_store/core/cubits/details_cubit/details_cubit.dart';
import 'package:our_store/views/favorite/logic/cubits/favorite_cubit/favorite_cubit.dart';
import 'package:our_store/views/home/logic/cubits/best_seller_view_cubit/best_seller_view_cubit.dart';
import 'package:our_store/views/main_home_view/logic/cubit/nav_bar_cubit.dart';
import 'package:our_store/views/products/logic/cubits/product_view_cubit/product_view_cubit.dart';
import 'package:our_store/secret_constants.dart';
import 'package:our_store/views/auth/logic/cubit/auth_cubit.dart';
import 'package:our_store/views/auth/ui/sign_up_view.dart';
import 'package:our_store/views/home/logic/cubits/discounts_view_cubit/discounts_view_cubit.dart';
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
        BlocProvider(create: (context) => NavBarCubit()),
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => DetailsCubit()),
        BlocProvider(create: (context) => ProductViewCubit()),
        BlocProvider(create: (context) => DiscountsViewCubit()),
        BlocProvider(create: (context) => FavoriteCubit()),
        BlocProvider(create: (context) => BestSellerViewCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Demo Store',
        theme: AppTheme.lightTheme,
        themeMode: ThemeMode.light,
        darkTheme: AppTheme.darkTheme,
        home: client.auth.currentUser == null ? SignUpView() : MainHomeView(),
      ),
    );
  }
}
