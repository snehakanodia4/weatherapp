import 'dart:convert';
import 'package:http/http.dart' as http;
import 'weather_model.dart';

class Repo {
  Future<WeatherModel?> getWeather(String? city) async {
    try {
      var url =
          "https://api.openweathermap.org/data/2.5/weather?q=$city&APPID=43ea6baaad7663dc17637e22ee6f78f2";

      final res = await http.get(Uri.parse(url));

      if (res.statusCode == 200) {
        return WeatherModel.fromJson(json.decode(res.body));
      } else {
        // If request fails, return null
        return null;
      }
    } catch (e) {
      // If an error occurs, throw an exception
      throw Exception('Failed to load weather data');
    }
  }
}
// /* {"coord":{"lon":73.8553,"lat":18.5196},
//"weather":[{"id":501,"main":"Rain","description":"moderate rain","icon":"10n"}],
//"base":"stations",
//"main":{"temp":300.29,"feels_like":302.61,"temp_min":300.29,"temp_max":300.29,
//"pressure":1007,"humidity":74,"sea_level":1007,"grnd_level":946},
//"visibility":10000,
//"wind":{"speed":3.54,"deg":263,"gust":4.93},"rain":{"1h":2.37},"clouds":{"all":64},"dt":1718549070,
//"sys":{"country":"IN","sunrise":1718497693,"sunset":1718545348},"timezone":19800,"id":1259229,
//"name":"Pune","cod":200} 
 