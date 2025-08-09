import 'package:dio/dio.dart';
import 'package:our_store/core/models/product_details_model.dart';
import 'package:our_store/core/models/product_view_model.dart';
import 'package:our_store/secret_constants.dart';
import 'package:our_store/views/home/logic/models/category_model.dart';
import 'package:our_store/views/home/logic/models/discounts_details_model.dart';
import 'package:our_store/views/home/logic/models/discounts_view_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final Dio _dio = Dio();

  final String supabaseUrl = url;
  final String supabaseKey = apiKey;
  SupabaseClient supabase = Supabase.instance.client;

  Future<List<CategoryModel>> fetchCategories() async {
    try {
      final List<dynamic> response =
          await supabase.rpc('get_unique_categories') as List<dynamic>;

      List<CategoryModel> modelList = response
          .map((e) => CategoryModel(label: e.toString()))
          .toList();

      print('Fetched categories: $modelList');

      return modelList;
    } catch (e) {
      throw Exception('Error fetching categories: $e');
    }
  }

  Future<List<DiscountsViewModel>> fetchDiscountsView() async {
    final url =
        '$supabaseUrl/rest/v1/discounts?select=products:for_product(id,created_at,name,price,old_price,image_url,discount)';
    final response = await _dio.get(
      url,
      options: Options(
        headers: {
          'apikey': supabaseKey,
          'Authorization': 'Bearer $supabaseKey',
        },
      ),
    );
    try {
      List dynamicList = response.data;
      List<DiscountsViewModel> discountsViewModel = (dynamicList)
          .map((e) => DiscountsViewModel.fromJson(e as Map<String, dynamic>))
          .toList();

      if (response.statusCode == 200) {
        print('Fetched products:');
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

  Future<List<DiscountsDetailsModel>> fetchDiscountsDetails({
    required String id,
  }) async {
    final url =
        '$supabaseUrl/rest/v1/discounts?select=products:for_product(description)&for_product=eq.$id';
    final response = await _dio.get(
      url,
      options: Options(
        headers: {
          'apikey': supabaseKey,
          'Authorization': 'Bearer $supabaseKey',
        },
      ),
    );
    try {
      List dynamicList = response.data;
      List<DiscountsDetailsModel> discountsDetailsModel = (dynamicList)
          .map((e) => DiscountsDetailsModel.fromJson(e as Map<String, dynamic>))
          .toList();

      if (response.statusCode == 200) {
        print('Fetched products:');
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
    required String category,
  }) async {
    final url =
        '$supabaseUrl/rest/v1/products?select=id,created_at,name,price,old_price,image_url,category&category=eq.$category';
    final response = await _dio.get(
      url,
      options: Options(
        headers: {
          'apikey': supabaseKey,
          'Authorization': 'Bearer $supabaseKey',
        },
      ),
    );
    try {
      List dynamicList = response.data;
      List<ProductViewModel> productViewModel = (dynamicList)
          .map((e) => ProductViewModel.fromJson(e as Map<String, dynamic>))
          .toList();

      if (response.statusCode == 200) {
        print('Fetched products:');
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

  Future<List<ProductDetailsModel>> fetchProductDetails({required String id}) async {
    final url = '$supabaseUrl/rest/v1/products?select=description&id=eq.$id';
    final response = await _dio.get(
      url,
      options: Options(
        headers: {
          'apikey': supabaseKey,
          'Authorization': 'Bearer $supabaseKey',
        },
      ),
    );
    try {
      List dynamicList = response.data;
      List<ProductDetailsModel> productDetailsModel = (dynamicList)
          .map((e) => ProductDetailsModel.fromJson(e as Map<String, dynamic>))
          .toList();

      if (response.statusCode == 200) {
        print('Fetched products:');
        print(response.data);
      } else {
        print('Failed with status code: ${response.statusCode}');
      }
      return productDetailsModel;
    } catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }
  }
}
