import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var API_KEY = "8868e7d431964dd89a265801230604";
  var URL;
  var cityController = TextEditingController();

  var city;
  var state;
  var country;
  var temperature;
  var weather_report;
  var humidity;
  var wind_speed;

  Future getweather(String city) async {
    var uri = Uri.parse(
        "http://api.weatherapi.com/v1/current.json?key=$API_KEY&q=$city&aqi=no");
    http.Response response = await http.get(uri);
    var result = jsonDecode(response.body);

    setState(() {
      this.city = result['location']['name'];
      this.state = result['location']['region'];
      this.country = result['location']['country'];
      this.temperature = result['current']['temp_c'];
      this.weather_report = result['current']['condition']['text'];
      this.humidity = result['current']['humidity'];
      this.wind_speed = result['current']['wind_kph'];
    });
  }

  @override
  void initState() {
    super.initState();
    this.getweather('Erode');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather Application"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.width,
            decoration: new BoxDecoration(
                image: new DecorationImage(
                    image: new AssetImage("sky.jpg"), fit: BoxFit.cover)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    this.city.toString(),
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(
                    "${this.temperature.toString()}°C",
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(
                    this.weather_report.toString(),
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: TextField(
                      controller: cityController,
                      decoration: InputDecoration(
                        hintText: "Enter city name",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        this.getweather(cityController.text);
                      });
                    },
                    child: Text("Search"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    leading: Icon(Icons.location_city),
                    title: Text("City"),
                    trailing: Text(this.city.toString()),
                  ),
                  ListTile(
                    leading: Icon(Icons.location_pin),
                    title: Text("State"),
                    trailing: Text(this.state.toString()),
                  ),
                  ListTile(
                    leading: Icon(Icons.location_searching),
                    title: Text("Country"),
                    trailing: Text(this.country.toString()),
                  ),
                  ListTile(
                    leading: Icon(Icons.thermostat_outlined),
                    title: Text("Temperature"),
                    trailing: Text("${this.temperature.toString()}°C"),
                  ),
                  ListTile(
                    leading: Icon(Icons.cloud),
                    title: Text("Weather"),
                    trailing: Text(this.weather_report.toString()),
                  ),
                  ListTile(
                    leading: Icon(Icons.opacity),
                    title: Text("Humidity"),
                    trailing: Text("${this.humidity.toString()}%"),
                  ),
                  ListTile(
                    leading: Icon(Icons.air),
                    title: Text("Wind Speed"),
                    trailing: Text("${this.wind_speed.toString()} km/h"),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
