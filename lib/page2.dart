import 'package:flutter/material.dart';
import 'package:weather_app/Models.dart';
import 'getData2.dart';

class Page2 extends StatefulWidget {
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  WeatherResponse _response2;
  TextEditingController city = TextEditingController();
  final _getData = getData2();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_response2 != null)
              Column(
                children: <Widget>[
                  Image.network(_response2.iconUrl),
                  Text('${_response2.tempInfo.temperature} °C'),
                  Text(_response2.weatherInfo.description),
                ],
              ),
            Padding(
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
            new RaisedButton(
                child: Text(
                  'Search',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue,
                onPressed: _search)
          ],
        ),
      ),
    );
  }

  void _search() async {
    final result = await _getData.getWeatherData(city.text);
    Future.delayed(Duration(seconds: 3));
    setState(() => _response2 = result);
  }
}
