import 'package:covidindiaflutter/Models/alldata_model.dart';
import 'package:covidindiaflutter/theme_changer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';
import 'package:covidindiaflutter/Models/dailydata_model.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    DailyDataModel dailyDataModel = DailyDataModel();
    var dailyData = await dailyDataModel.getData();

    AllDataModel allDataModel = AllDataModel();
    var allData = await allDataModel.getData();

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return HomeScreen(
        dailyData: dailyData,
        allData: allData,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    ThemeData _themeData = Provider.of<ThemeChanger>(context).getTheme;
    Color spinnerColor =
        _themeData == ThemeData.light() ? Colors.black : Colors.white;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Hero(
              tag: 'covid19',
              child: Material(
                color: Colors.transparent,
                child: Text(
                  'Covid 19',
                  style: TextStyle(fontSize: 40),
                  textAlign: TextAlign.center,
                ),
              )),
          SizedBox(
            height: 35,
          ),
          SpinKitThreeBounce(
            color: spinnerColor,
            size: 40.0,
          ),
        ],
      ),
    );
  }
}
