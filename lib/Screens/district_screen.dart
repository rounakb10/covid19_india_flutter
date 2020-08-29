import 'dart:collection';
import 'package:flutter/material.dart';
//import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import '../theme_changer.dart';

class DistrictScreen extends StatefulWidget {
  DistrictScreen({this.stateName, this.stateCode, this.index, this.allData});
  final String stateName;
  final String stateCode;
  final int index;
  final allData;
  @override
  _DistrictScreenState createState() => _DistrictScreenState();
}

class _DistrictScreenState extends State<DistrictScreen> {
  List<int> recovered;
  List<int> deceased;
  List<int> confirmed;
  List<String> districtName;

  List<int> recoveredDelta;
  List<int> deceasedDelta;
  List<int> confirmedDelta;
  HashMap map = HashMap<String, String>();

  String stateName;
  String _index;
  @override
  void initState() {
    super.initState();
    stateName = widget.stateName;
    _index = widget.index.toString();
    updateUI(widget.allData, widget.stateCode);
  }

  void updateUI(dynamic allData, String stateCode) {
    setState(() {
      if (allData == null) {
        return;
      }

      Map data = allData[stateCode]['districts'];
      int size = data.length;

      confirmed = new List(size);
      deceased = new List(size);
      recovered = new List(size);
      districtName = new List(size);
      confirmedDelta = new List(size);
      deceasedDelta = new List(size);
      recoveredDelta = new List(size);

      districtName = data.keys.toList();

      for (int i = 0; i < size; i++) {
        //WB.districts.Malda.total.confirmed
        try {
          confirmed[i] = allData[stateCode]['districts'][districtName[i]]
                  ['total']['confirmed']
              .toDouble()
              .toInt();
        } catch (e) {
          confirmed[i] = 0;
        }
        if (confirmed[i] == null) throw Exception;
        try {
          recovered[i] = allData[stateCode]['districts'][districtName[i]]
                  ['total']['recovered']
              .toDouble()
              .toInt();
          if (recovered[i] == null) throw Exception;
        } catch (e) {
          recovered[i] = 0;
        }

        try {
          deceased[i] = allData[stateCode]['districts'][districtName[i]]
                  ['total']['deceased']
              .toDouble()
              .toInt();
          if (deceased[i] == null) throw Exception;
        } catch (e) {
          deceased[0] = 0;
        }

        try {
          confirmedDelta[i] = allData[stateCode]['districts'][districtName[i]]
                  ['delta']['confirmed']
              .toDouble()
              .toInt();
          if (confirmedDelta[i] == null) throw Exception;
        } catch (e) {
          confirmedDelta[i] = 0;
        }

        try {
          recoveredDelta[i] = allData[stateCode]['districts'][districtName[i]]
                  ['delta']['recovered']
              .toDouble()
              .toInt();
          if (recoveredDelta[i] == null) throw Exception;
        } catch (e) {
          recoveredDelta[i] = 0;
        }

        try {
          deceasedDelta[i] = allData[stateCode]['districts'][districtName[i]]
                  ['delta']['deceased']
              .toDouble()
              .toInt();
          if (deceasedDelta[i] == null) throw Exception;
        } catch (e) {
          deceasedDelta[i] = 0;
        }

        if (deceasedDelta[i] == null) deceasedDelta[i] = 0;
        if (deceased[i] == null) deceased[i] = 0;
        if (confirmed[i] == null) confirmed[i] = 0;
        if (confirmedDelta[i] == null) confirmedDelta[i] = 0;
        if (recovered[i] == null) recovered[i] = 0;
        if (recoveredDelta[i] == null) recoveredDelta[i] = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Hero(
          tag: 'stateName' + _index,
          child: Material(
            color: Colors.transparent,
            child: Text(
              stateName,
              style: TextStyle(fontSize: 22),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      body: _myListView(context),
    );
  }

  Widget _myListView(BuildContext context) {
    ThemeData _themeData = Provider.of<ThemeChanger>(context).getTheme;
    Color subtitleText = _themeData == ThemeData.light()
        ? Colors.grey.shade900
        : Colors.grey.shade300;
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: districtName.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          margin: index == 0
              ? EdgeInsets.only(left: 8.0, right: 8.0, top: 11.0, bottom: 6.0)
              : index == districtName.length - 1
                  ? EdgeInsets.only(
                      left: 8.0, right: 8.0, top: 6.0, bottom: 12.0)
                  : EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
          child: ListTile(
            title: Text(
              districtName[index],
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              'Total:' +
                  confirmed[index].toString() +
                  (confirmedDelta[index] != 0
                      ? ('(+${confirmedDelta[index].toString()})')
                      : '') +
                  '  Recovered:' +
                  recovered[index].toString() +
                  (recoveredDelta[index] != 0
                      ? ('(+${recoveredDelta[index].toString()})')
                      : '') +
                  '  Deaths:' +
                  deceased[index].toString() +
                  (deceasedDelta[index] != 0
                      ? ('(+${deceasedDelta[index].toString()})')
                      : ''),
              style: TextStyle(
                fontSize: 17.5,
                color: subtitleText,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}
