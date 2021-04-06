import 'package:flutter/material.dart';
import 'package:weather_app/page2.dart';
import 'getData.dart';
import 'package:weather_app/Models.dart';
import 'package:geolocator/geolocator.dart';

void main() => runApp(Weather());

class Weather extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Position _currentPosition;

  TextEditingController city = TextEditingController();
  final _getData = getData();

  WeatherResponse _response;

  @override
  void initState() {
    super.initState();

    getPosition().then((position) async {
      final result = await _getData.getWeatherData(
          position.latitude.toString(), position.longitude.toString());
      print(result.cityName);
      print(result.tempInfo.temperature);
      print(result.weatherInfo.description);
      setState(() {
        _response = result;
      });
    });
  }

  Future<Position> getPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather of current location'),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_response != null)
              Column(
                children: <Widget>[
                  Image.network(_response.iconUrl),
                  Text('${_response.tempInfo.temperature} °C'),
                  Text(_response.weatherInfo.description),
                  Text(_response.cityName),
                ],
              ),
            new RaisedButton(
              child: Text(
                'Other Locations',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Page2()),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
