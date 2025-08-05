import 'package:dio/dio.dart';

import 'package:our_store/secret_constants.dart';
import 'package:our_store/views/home/logic/models/category_model.dart';
import 'package:our_store/views/home/logic/models/discounts_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final Dio _dio = Dio();

  final String supabaseUrl = url;
  final String supabaseKey = apiKey;
  SupabaseClient supabase=Supabase.instance.client;

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


  Future<List<DiscountModel>> fetchDiscounts({required String parametersValue}) async {

    
    final url =
        '$supabaseUrl/rest/v1/discounts?select=*,products:for_product($parametersValue)';

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
      print(e.toString());
      throw Exception(e.toString());
    }
  }

  // Future<List<ProductModel>> fetchProducts() async {
  //   final url = '$supabaseUrl/rest/v1/products';

  //   final response = await _dio.get(
  //     url,
  //     options: Options(
  //       headers: {
  //         'apikey': supabaseKey,
  //         'Authorization': 'Bearer $supabaseKey',
  //       },
  //     ),
  //   );

  //   try {
  //     List dynamicList = response.data;
  //     List<DiscountModel> discountModelList = (dynamicList)
  //         .map((e) => DiscountModel.fromJson(e as Map<String, dynamic>))
  //         .toList();
  //     if (response.statusCode == 200) {
  //       print('Fetched products:');
  //       print(response.data);
  //     } else {
  //       print('Failed with status code: ${response.statusCode}');
  //     }
  //     return discountModelList;
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   }
  // }
}
