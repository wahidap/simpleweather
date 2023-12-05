import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:simpleweather/weather_pages/model/view/weather_model.dart';

class WeatherService {
  final String apiKey;
  final String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  WeatherService(this.apiKey);


Future<WeatherModel> getWeatherByLocation(double latitude, double longitude) async {
  final Uri uri = Uri.parse(
    '$baseUrl?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric',
  );

  final response = await http.get(uri);

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    return WeatherModel(
      cityName: data['name'],
      temperature: data['main']['temp'],
      description: data['weather'][0]['description'],
    );
  } else {
    throw Exception('Failed to load weather data');
  }
}
}