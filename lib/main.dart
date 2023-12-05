import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:simpleweather/weather_pages/model/view/weather_model.dart';
import 'package:simpleweather/weather_pages/service/view/weather_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late WeatherService weatherService;
  WeatherModel? weather;

  @override
  void initState() {
    super.initState();
    weatherService = WeatherService('a49a5eb9112875bcedbf442830a01c91');
    fetchWeatherByLocation();
  }

  Future<void> fetchWeatherByLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        // Handle permission denial
        print('Location permission denied');
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
      );

      WeatherModel result = await weatherService.getWeatherByLocation(
        position.latitude,
        position.longitude,
      );

      setState(() {
        weather = result;
      });
    } catch (e) {
      print('Error fetching weather: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(1, 255, 255, 255),
        elevation: 0,
        title: Text('Weather App'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://www.google.com/url?sa=i&url=https%3A%2F%2Fdev.to%2Fcscarpitta%2Fcreating-a-simple-weather-app-with-python-and-flask-5bpd&psig=AOvVaw0z_Qk5G7T8tGFPzyBe5nE5&ust=1701898770294000&source=images&cd=vfe&ved=0CBIQjRxqFwoTCMC4go-h-YIDFQAAAAAdAAAAABAJ'), // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: weather != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'City: ${weather!.cityName}',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Temperature: ${weather!.temperature}°C',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Description: ${weather!.description}',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                )
              : CircularProgressIndicator(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchWeatherByLocation,
        tooltip: 'Refresh',
        child: Icon(Icons.refresh),
      ),
    );
  }
}
