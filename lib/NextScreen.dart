import 'package:flutter/material.dart';
import 'repo.dart';
import 'weather_model.dart';

class NextScreen extends StatefulWidget {
  final String initialLocation;

  const NextScreen({Key? key, required this.initialLocation}) : super(key: key);

  @override
  State<NextScreen> createState() => _NextScreenState();
}

class _NextScreenState extends State<NextScreen> {
  TextEditingController controller = TextEditingController();
  WeatherModel? weatherModel;

  @override
  void initState() {
    super.initState();
    controller.text = widget.initialLocation;
    _fetchWeather(widget.initialLocation);
  }

  Future<void> _fetchWeather(String city) async {
    WeatherModel? weather = await Repo().getWeather(city);
    setState(() {
      weatherModel = weather;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromRGBO(248, 240, 198, 0.875),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 227, 182, 2),
          title: Text("Weather App"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Enter the name of a City',
                    style: TextStyle(
                        fontSize: 40,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 20,
                    width: 200,
                  ),
                  TextField(
                    controller: controller,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.search_rounded, size: 18),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 227, 182, 2)),
                    onPressed: () async {
                      String city = controller.text;
                      await _fetchWeather(city);
                    },
                    label: Text('SEARCH'),
                  ),
                  SizedBox(
                      height:
                          16.0), // Adding some space between Button and Weather info
                  if (weatherModel != null)
                    Center(
                      child: Column(
                        children: [
                          Table(
                            columnWidths: {
                              0: FlexColumnWidth(1),
                              1: FlexColumnWidth(2),
                            },
                            children: [
                              TableRow(children: [
                                Text("Temperature:"),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text("${weatherModel?.main?.temp}"),
                                ),
                              ]),
                              TableRow(children: [
                                Text("Feels Like:"),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child:
                                      Text("${weatherModel?.main?.feelsLike}"),
                                ),
                              ]),
                              TableRow(children: [
                                Text("Minimum Temperature:"),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text("${weatherModel?.main?.tempMin}"),
                                ),
                              ]),
                              TableRow(children: [
                                Text("Maximum Temperature:"),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text("${weatherModel?.main?.tempMax}"),
                                ),
                              ]),
                              TableRow(children: [
                                Text("Pressure:"),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child:
                                      Text("${weatherModel?.main?.pressure}"),
                                ),
                              ]),
                              TableRow(children: [
                                Text("Humidity:"),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child:
                                      Text("${weatherModel?.main?.humidity}"),
                                ),
                              ]),
                              TableRow(children: [
                                Text("Wind Gust:"),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text("${weatherModel?.wind?.gust}"),
                                ),
                              ]),
                              TableRow(children: [
                                Text("Wind Speed:"),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text("${weatherModel?.wind?.speed}"),
                                ),
                              ]),
                              TableRow(children: [
                                Text("Wind Degree:"),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text("${weatherModel?.wind?.deg}"),
                                ),
                              ]),
                            ],
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
