import 'dart:convert';
import 'dart:io';

import 'package:diresto/data/api/api_service.dart';
import 'package:diresto/data/model/restaurant.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([http.Client])
void main() {
  group('RestaurantList', () {
    ApiService? apiService;

    setUp(() {
      apiService = ApiService();
    });

    test('should return the same restaurant image when given the sample', () async {
      //act
      String pictureIdSample = "22";
      String sizeSample = 'small';
      String imageUrl = 'https://restaurant-api.dicoding.dev/images/small/22';

      //assert
      var result = apiService!.restaurantImage(sizeSample, pictureIdSample).contains(imageUrl);
      expect(result, true);
    });

    test('should return the same value in the parsing json process when given the samples', () {
      //act
      var file = File('test/resources/restaurant_list.json').readAsStringSync();
      var resto = Restaurant.fromJson(jsonDecode(file) as Map<String, dynamic>);
      int sampleOne = 20;
      String sampleTwo = 'Kafe Kita';
      
      //assert
      var resultOne = resto.count;
      var resultTwo = resto.restaurants[1].name;
      expect(resultOne, sampleOne);
      expect(resultTwo, sampleTwo);
    });

    test('should returns a given sample restaurant if the http call succeed', () async {
      //act
      apiService!.client = MockClient((request) async {
        final mapJson = {
          'error': false,
          'message': 'success',
          'count': 20,
          "restaurants": [
            {
              "id": "rqdv5juczeskfw1e867",
              "name": "Melting Pot",
              "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
              "pictureId": "14",
              "city": "Medan",
              "rating": 4.2
            },
          ]
        };
        return http.Response(json.encode(mapJson), 200);
      });

      //assert
      final fetchResto = await apiService!.testFetchRestaurantList();
      final result = fetchResto.restaurants[0].id;
      expect(result, 'rqdv5juczeskfw1e867');
    });
  });
}
