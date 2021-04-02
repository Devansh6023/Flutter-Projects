import 'package:flutter/material.dart';
import 'getData.dart';
import 'package:weather_app/Models.dart';
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
  TextEditingController city = TextEditingController();
  final _getData = getData();

  WeatherResponse _response;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_response != null)
              Column(
                children: [
                  Image.network(_response.iconUrl),
                  Text(
                      '${_response.tempInfo.temperature}'
                  ),
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
                        suffixIcon: Icon(Icons.location_on, color: Colors.blue,),
                        labelStyle: TextStyle(
                          color: Colors.blue,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        enabledBorder: OutlineInputBorder(
                         borderSide: BorderSide(color: Colors.blue)
                        ),

                        ),
                    //keyboardType: TextInputType.,
                  ),
                ),
              ),
            ),
            RaisedButton(
              child: Text('Search', style: TextStyle(color: Colors.white),),
              color: Colors.blue,
              onPressed: _search,
            ),
          ],
        ),
      ),
    );
  }
  void _search() async {
    final result = await _getData.getWeatherData(city.text);
    setState(() => _response = result);
  }
}