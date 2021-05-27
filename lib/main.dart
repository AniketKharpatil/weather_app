import 'package:flutter/material.dart';
import 'package:weather_app/data_service.dart';
import 'models.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Myappstate();
}

class _Myappstate extends State<MyApp> {
  final _citytextcontrol = TextEditingController();
  final _dataservice = DataService();
  String bgImg;
  WeatherResponse _response;
  @override
  Widget build(BuildContext context) {
    bgImg = 'assets/sunny.jpg';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Weather App ', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.indigo[300],
        ),
        body: Center(
          child: Container(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("Weather App",
                  style: TextStyle(
                      color: Colors.blue[800],
                      fontSize: 28,
                      fontWeight: FontWeight.bold)),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              if (_response != null)
                Column(children: [
                  Image.network(_response.iconUrl),
                  Text(
                    _response.cityName,
                    style: TextStyle(fontSize: 28),
                  ),
                  Text(
                    _response.sysInfo.countryName,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _response.weatherInfo.description,
                    style: TextStyle(fontSize: 21),
                  ),
                  Text(
                    '${_response.tempInfo.temperature}°',
                    style: TextStyle(fontSize: 38, color: Colors.black),
                  ),
                ]),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: SizedBox(
                  width: 200,
                  child: TextField(
                    controller: _citytextcontrol,
                    decoration: InputDecoration(
                      labelText: "Enter City",
                      labelStyle: TextStyle(
                          color: Colors.greenAccent[400], fontSize: 26),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              ElevatedButton(
                //style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith((states) => null)),
                  onPressed: _search,
                  child: Text(
                    "Search",
                    style: TextStyle(fontSize: 28),
                  ))
            ]),
          ),
        ),
      ),
    );
  }

  void _search() async {
    final response = await _dataservice.getWeather(_citytextcontrol.text);
    /*print(response.cityName);
    print(response.tempInfo.temperature);
    print(response.weatherInfo.description);*/
    setState(() => _response = response);
  }
}
