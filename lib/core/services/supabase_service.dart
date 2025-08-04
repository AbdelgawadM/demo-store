import 'package:dio/dio.dart';
import 'package:our_store/core/models/product_model.dart';
import 'package:our_store/secret_constants.dart';
import 'package:our_store/views/home/logic/models/category_model.dart';
import 'package:our_store/views/home/logic/models/discounts_model.dart';

class SupabaseService {
  final Dio _dio = Dio();

  final String supabaseUrl = url;
  final String supabaseKey = apiKey;

  Future<List<CategoryModel>> fetchCategories() async {
    final url = '$supabaseUrl/rest/v1/products?select=category';

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
      List<CategoryModel> modelList = (dynamicList)
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList();
      if (response.statusCode == 200) {
        print('Fetched products:');
        print(response.data);
      } else {
        print('Failed with status code: ${response.statusCode}');
      }
      return modelList;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<DiscountModel>> fetchDiscounts() async {
    final url = '$supabaseUrl/rest/v1/discounts?select=*,products:for_product(*)';

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
      List<DiscountModel> discountModelList = (dynamicList)
          .map((e) => DiscountModel.fromJson(e as Map<String, dynamic>))
          .toList();
      if (response.statusCode == 200) {
        print('Fetched products:');
        print(response.data);
      } else {
        print('Failed with status code: ${response.statusCode}');
      }
      return discountModelList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
