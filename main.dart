import 'package:flutter/material.dart';
import 'getData.dart';
import 'package:weather_app/Models.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

void main() => runApp(Weather());

class Weather extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather',
      theme: ThemeData(primarySwatch: Colors.grey),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Position _currentPosition;
  String _currentAddress;

  TextEditingController city = TextEditingController();
  final _getData = getData();

  WeatherResponse _response;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                _getCurrentLocation();
              },
              child: Icon(Icons.location_city, size: 36),
            ),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
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
                  Text('${_response.tempInfo.temperature}'),
                  Text(_response.weatherInfo.description)
                ],
              ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: TextField(
                    style: TextStyle(color: Colors.blue, fontSize: 30),
                    controller: city,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: ('Delhi'),
                      labelText: ('City'),
                      hintStyle: TextStyle(
                        color: Colors.blue,
                        fontSize: 30.0,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.italic,
                      ),
                      suffixIcon: Icon(
                        Icons.location_on,
                        color: Colors.blue,
                      ),
                      labelStyle: TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)),
                    ),
                  ),
                ),
              ),
            ),
            new RaisedButton(
              child: Text(
                'Search',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
              onPressed: _search,
            )
          ],
        ),
      ),
    );
  }

  void _search() async {
    final result = await _getData.getWeatherData(city.text);
    setState(() => _response = result);
  }

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _getAddressFromLatLng();
      });
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress = "${place.locality}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }
}
