import 'package:our_store/views/auth/logic/cubit/auth_cubit.dart';
import 'package:our_store/views/favorite/logic/models/favorite_model.dart';
import 'package:our_store/core/models/details_model.dart';
import 'package:our_store/views/products/logic/models/product_view_model.dart';
import 'package:our_store/core/services/api_services.dart';
import 'package:our_store/views/home/logic/models/category_model.dart';
import 'package:our_store/views/home/logic/models/discounts_view_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  SupabaseClient supabase = Supabase.instance.client;
  ApiServices apiServices = ApiServices();
  late final String mainUserId = AuthCubit().client.auth.currentUser!.id;

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
    final response = await apiServices.getData(
      'discounts?select=discount_id,discount,new_price,products:products!for_product(name,price,image_url,product_id,favorites!left(favorite_id),product_avg_rates(avg_rate))&products.favorites.for_user=eq.$mainUserId',
    );
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
      'discounts?select=products:for_product(description,rates(rate))&products.rates.for_user=eq.$mainUserId&for_product=eq.$productId',
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
      'products?select=product_id,name,price,image_url,product_avg_rates(avg_rate),favorites!left(favorite_id)&favorites.for_user=eq.$mainUserId&category_id=eq.$categoryId',
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
    required String userId,
  }) async {
    final response = await apiServices.getData(
      'products?select=description,rates(rate)&rates.for_user=eq.$userId&product_id=eq.$productId',
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

  Future<List<FavoriteModel>> fetchFavorites() async {
    final response = await apiServices.getData(
      'favorites?select=favorite_id,products:for_product(name,price,image_url,product_id,product_avg_rates(avg_rate))&for_user=eq.$mainUserId',
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

  Future<void> addFavorite({required String productId}) async {
    try {
      final Map<String, dynamic> favoriteJson = FavoriteModel.toJson(
        userId: mainUserId,
        productId: productId,
      );
      final response = await apiServices.postData('favorites', favoriteJson);

      if (response.statusCode == 201 || response.statusCode == 200) {
        print('Favorite added successfully to server');
      } else {
        print('Failed to add favorite: ${response.statusCode}');
        throw Exception('error in add request :${response.statusCode}');
      }
    } catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<void> removeFavorite({required String productId}) async {
    try {
      final response = await apiServices.deleteData(
        'favorites?for_product=eq.$productId&for_user=eq.$mainUserId',
      );

      if (response.statusCode == 204 || response.statusCode == 200) {
        print('Favorite removed successfully from server');
      } else {
        print('Failed to remove favorite: ${response.statusCode}');
        throw Exception('error in delete request :${response.statusCode}');
      }
    } catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<List<ProductViewModel>> fetchBestSellerView() async {
    final response = await apiServices.getData(
      'best_seller?select=products(name,price,image_url,product_id,product_avg_rates(avg_rate),favorites!left(favorite_id))&products.favorites.for_user=eq.$mainUserId',
    );
    try {
      List dynamicList = response.data;
      List<ProductViewModel> productViewModel = (dynamicList)
          .map(
            (e) => ProductViewModel.fromJson(
              e['products'] as Map<String, dynamic>,
            ),
          )
          .toList();

      if (response.statusCode == 200) {
        print('Fetched best seller view:');
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
}
