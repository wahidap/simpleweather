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

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       backgroundColor: Colors.brown,
  //       title: Text('Weather App'),
  //     ),
  //     body:  Container(
  //       decoration: BoxDecoration(
  //         image: DecorationImage(image:AssetImage('assets/IMG_7141.png'),
  //         fit: BoxFit.cover),
          
  //       ),
  //         child: Center(
  //           child: weather != null
  //               ? Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Text(
  //                       'City: ${weather!.cityName}',
  //                       style: TextStyle(fontSize: 18),
  //                     ),
  //                     Text(
  //                       'Temperature: ${weather!.temperature}°C',
  //                       style: TextStyle(fontSize: 18),
  //                     ),
  //                     Text(
  //                       'Description: ${weather!.description}',
  //                       style: TextStyle(fontSize: 18),
  //                     ),
  //                   ],
  //                 )
  //               : CircularProgressIndicator(),
                
  //         ),
  //       ),
  //     floatingActionButton: FloatingActionButton(

  //      backgroundColor: Colors.brown,
  //       onPressed: fetchWeatherByLocation,
  //       tooltip: 'Refresh',
  //       child: Icon(Icons.refresh),
  //     ),


  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.brown,
      title: Text('Weather App'),
    ),
    body: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/IMG_7141.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Center(
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
        // // Add more pictures above the background image
        // Positioned(
        //   top: 53,
        //   left: 34,
        //   child: Image.asset(
        //     'assets/Frame 2.png',
        //     width: 300,
        //     height: 280,
        //     fit: BoxFit.cover,
        //   ),
        // ),
        Positioned(
          top: 474,
          left: 34,
          child: Image.asset(
            'assets/Frame 3.png',
            width: 300,
            height: 150,
            fit: BoxFit.cover,
          ),
        ),
        // Add more Positioned widgets for additional images
      ],
    ),
    floatingActionButton: FloatingActionButton(
      backgroundColor: Colors.brown,
      onPressed: fetchWeatherByLocation,
      tooltip: 'Refresh',
      child: Icon(Icons.refresh),
    ),
  );
}
}