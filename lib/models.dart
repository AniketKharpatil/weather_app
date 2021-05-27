/*
                          

{
  "coord": {
    "lon": -122.08,
    "lat": 37.39
  },
  "weather": [
    {
      "id": 800,
      "main": "Clear",
      "description": "clear sky",
      "icon": "01d"
    }
  ],
  "base": "stations",
  "main": {
    "temp": 282.55,
    "feels_like": 281.86,
    "temp_min": 280.37,
    "temp_max": 284.26,
    "pressure": 1023,
    "humidity": 100
  },
  "visibility": 16093,
  "wind": {
    "speed": 1.5,
    "deg": 350
  },
  "clouds": {
    "all": 1
  },
  "dt": 1560350645,
  "sys": {
    "type": 1,
    "id": 5122,
    "message": 0.0139,
    "country": "US",
    "sunrise": 1560343627,
    "sunset": 1560396563
  },
  "timezone": -25200,
  "id": 420006353,
  "name": "Mountain View",
  "cod": 200
  }                         

                        
 */
class WeatherInfo {
  final String description;
  final String icon;

  WeatherInfo({this.description,this.icon});

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    final description = json['description'];
    final icon = json['icon'];
    return WeatherInfo(description: description,icon: icon);
  }
}

class SysInfo {
  final String countryName;
  SysInfo({this.countryName});

  factory SysInfo.fromJson(Map<String, dynamic> json) {
    final countryName = json['country'];
    return SysInfo(countryName:countryName);
  }
}

class TempInfo {
  final double temperature;
  TempInfo({this.temperature});

  factory TempInfo.fromJson(Map<String, dynamic> json) {
    final temperature = json['temp'];
    return TempInfo(temperature: temperature);
  }
}

class WeatherResponse {
  final String cityName;
  final SysInfo sysInfo;
  final TempInfo tempInfo;
  final WeatherInfo weatherInfo;

  String get iconUrl{
    return 'https://openweathermap.org/img/wn/${weatherInfo.icon}@2x.png';
  }

  WeatherResponse({this.cityName, this.tempInfo,this.weatherInfo,this.sysInfo});

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    final cityName = json['name'];

    final tempInfoJson = json['main'];
    final tempInfo = TempInfo.fromJson(tempInfoJson);

    final sysInfoJson = json['sys'];
    final sysInfo = SysInfo.fromJson(sysInfoJson);

    final weatherInfoJson = json['weather'][0];
    final weatherInfo=WeatherInfo.fromJson(weatherInfoJson);

    return WeatherResponse(cityName: cityName,sysInfo: sysInfo,tempInfo: tempInfo,weatherInfo:weatherInfo);
  }
}
