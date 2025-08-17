import 'package:our_store/core/models/favorite_model.dart';
import 'package:our_store/core/models/details_model.dart';
import 'package:our_store/core/models/product_view_model.dart';
import 'package:our_store/core/services/api_services.dart';
import 'package:our_store/views/home/logic/models/category_model.dart';
import 'package:our_store/views/home/logic/models/discounts_view_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  SupabaseClient supabase = Supabase.instance.client;
  ApiServices apiServices = ApiServices();

  Future<List<CategoryModel>> fetchCategories() async {
    final response = await apiServices.getData('categories');
    try {
      List dynamicList = response.data;

      List<CategoryModel> categoryModel = (dynamicList)
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList();

      print('Fetched categories: ');
      print(response);

      return categoryModel;
    } catch (e) {
      throw Exception('Error fetching categories: $e');
    }
  }

  Future<List<DiscountsViewModel>> fetchDiscountsView() async {
    final response = await apiServices.getData('discounts_with_avg_rating');
    try {
      List dynamicList = response.data;
      List<DiscountsViewModel> discountsViewModel = (dynamicList)
          .map((e) => DiscountsViewModel.fromJson(e as Map<String, dynamic>))
          .toList();

      if (response.statusCode == 200) {
        print('Fetched discount view:');
        print(response.data);
      } else {
        print('Failed with status code: ${response.statusCode}');
      }
      return discountsViewModel;
    } catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<List<DetailsModel>> fetchDiscountsDetails({
    required String productId,
  }) async {
    final response = await apiServices.getData(
      'discounts?select=products:for_product(description)&for_product=eq.$productId',
    );

    try {
      List dynamicList = response.data;
      List<DetailsModel> discountsDetailsModel = (dynamicList)
          .map(
            (e) => DetailsModel.fromJson(e['products'] as Map<String, dynamic>),
          )
          .toList();

      if (response.statusCode == 200) {
        print('fetched discount details');
        print(response.data);
      } else {
        print('Failed with status code: ${response.statusCode}');
      }
      return discountsDetailsModel;
    } catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<List<ProductViewModel>> fetchProductView({
    required String categoryId,
  }) async {
    final response = await apiServices.getData(
      'products_with_avg_rating?category_id=eq.$categoryId',
    );
    try {
      List dynamicList = response.data;
      List<ProductViewModel> productViewModel = (dynamicList)
          .map((e) => ProductViewModel.fromJson(e as Map<String, dynamic>))
          .toList();

      if (response.statusCode == 200) {
        print('Fetched product view:');
        print(response.data);
      } else {
        print('Failed with status code: ${response.statusCode}');
      }
      return productViewModel;
    } catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<List<DetailsModel>> fetchProductDetails({
    required String productId,
  }) async {
    final response = await apiServices.getData(
      'products?select=description&product_id=eq.$productId',
    );
    try {
      List dynamicList = response.data;
      List<DetailsModel> detailsModel = (dynamicList)
          .map((e) => DetailsModel.fromJson(e as Map<String, dynamic>))
          .toList();

      if (response.statusCode == 200) {
        print('Fetched product details:');
        print(response.data);
      } else {
        print('Failed with status code: ${response.statusCode}');
      }
      return detailsModel;
    } catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<List<FavoriteModel>> fetchFavorites({required String userId}) async {
    final response = await apiServices.getData(
      'favorites_with_rating?for_user=eq.$userId',
    );
    try {
      List dynamicList = response.data;
      List<FavoriteModel> favoriteModel = (dynamicList)
          .map((e) => FavoriteModel.fromJson(e as Map<String, dynamic>))
          .toList();

      if (response.statusCode == 200) {
        print('Fetched favorites:');
        print(response.data);
      } else {
        print('Failed with status code: ${response.statusCode}');
      }
      return favoriteModel;
    } catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<void> addFavorite({
    required String userId,
    required String productId,
  }) async {
    try {
      final Map<String, dynamic> favoriteJson = FavoriteModel.toJson(
        userId: userId,
        productId: productId,
      );
      final response = await apiServices.postData('favorites', favoriteJson);

      if (response.statusCode == 201 || response.statusCode == 200) {
        print('Favorite added successfully');
      } else {
        print('Failed to add favorite: ${response.statusCode}');
      }
    } catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }
  }
}
