//import 'package:flutter/material.dart';
//
//class DistrictDetail extends StatefulWidget {
//  DistrictDetail(
//      {this.confirmed,
//      this.deceased,
//      this.recovered,
//      this.districtName,
//      this.index,
//      this.zone});
//  final String districtName;
//  final int confirmed;
//  final int recovered;
//  final int deceased;
//  final int index;
//  final String zone;
//  @override
//  _DistrictDetailState createState() => _DistrictDetailState();
//}
//
//class _DistrictDetailState extends State<DistrictDetail> {
//  String _districtName;
//  int _confirmed;
//  int _recovered;
//  int _deceased;
//  int _index;
//  String _zone;
//
//  @override
//  void initState() {
//    super.initState();
//    _districtName = widget.districtName;
//    _confirmed = widget.confirmed;
//    _deceased = widget.deceased;
//    _recovered = widget.recovered;
//    _index = widget.index;
//    _zone = widget.zone;
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      backgroundColor: Color(0xff121212),
//      body: Hero(
//        tag: 'card$_index',
//        child: GestureDetector(
//          onTap: () {
//            Navigator.pop(context);
//          },
//          child: SingleChildScrollView(
//            physics: NeverScrollableScrollPhysics(),
//            child: Card(
//              elevation: 0,
//              child: Column(
//                crossAxisAlignment: CrossAxisAlignment.stretch,
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: <Widget>[
//                  SizedBox(
//                    height: 213.0,
//                  ),
//                  Text(
//                    _districtName,
//                    textAlign: TextAlign.center,
//                    style: TextStyle(
//                        fontSize: 42,
//                        //color: Colors.white,
//                        fontWeight: FontWeight.bold),
//                  ),
//                  SizedBox(
//                    height: 54.0,
//                  ),
//                  Text(
//                    'Active : ' +
//                        (_confirmed - _recovered - _deceased).toString(),
//                    style: TextStyle(
//                      fontSize: 32.0,
//                      color: Colors.yellow,
//                    ),
//                    textAlign: TextAlign.center,
//                  ),
//                  SizedBox(
//                    height: 7.0,
//                  ),
//                  Text(
//                    'Recovered : ' + _recovered.toString(),
//                    style: TextStyle(
//                      fontSize: 32.0,
//                      color: Colors.green,
//                    ),
//                    textAlign: TextAlign.center,
//                  ),
//                  SizedBox(
//                    height: 7.0,
//                  ),
//                  Text(
//                    'Deaths : ' + _deceased.toString(),
//                    style: TextStyle(
//                      fontSize: 32.0,
//                      color: Colors.red,
//                    ),
//                    textAlign: TextAlign.center,
//                  ),
//                  SizedBox(
//                    height: 40.0,
//                  ),
//                  Text(
//                    'Total : ' + _confirmed.toString(),
//                    style: TextStyle(
//                      fontSize: 32.0,
//                      color: Colors.blue,
//                    ),
//                    textAlign: TextAlign.center,
//                  ),
//                  _myWidget(),
//                  SizedBox(
//                    height: 270.0,
//                  ),
//                ],
//              ),
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//
//  Widget _myWidget() {
//    Color color;
//    if (_zone == 'Red')
//      color = Colors.red[600];
//    else if (_zone == 'Orange')
//      color = Colors.orange[800];
//    else if (_zone == 'Green') color = Colors.green[600];
//
//    if (_zone != null) {
//      return Container(
//        margin: EdgeInsets.symmetric(horizontal: 103.0, vertical: 26.0),
//        padding: EdgeInsets.symmetric(vertical: 12.0),
//        decoration: BoxDecoration(
//          color: color,
//          borderRadius: BorderRadius.circular(14.0),
//        ),
//        child: Text(
//          _zone + ' Zone',
//          style: TextStyle(
//            fontSize: 32.0,
//            fontWeight: FontWeight.w700,
//            letterSpacing: 1.2,
//          ),
//          textAlign: TextAlign.center,
//        ),
//      );
//    } else
//      return Text('');
//  }
//}
