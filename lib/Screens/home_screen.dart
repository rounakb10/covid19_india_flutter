import 'package:covidindiaflutter/Models/alldata_model.dart';
import 'package:covidindiaflutter/Screens/district_screen.dart';
//import 'package:flutter/services.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'package:covidindiaflutter/theme_changer.dart';
import 'package:flutter/material.dart';
//import 'package:covidindiaflutter/Models/state_model.dart';
import 'package:morpheus/morpheus.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import '../Utilities/get_state_code.dart';
import 'package:covidindiaflutter/Models/dailydata_model.dart';
import 'package:covidindiaflutter/Utilities/get_state_name.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({this.dailyData, this.allData, this.page});
  final dailyData;
  final allData;
  final int page;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<int> deaths;
  List<int> discharged;
  List<int> total;
  List<int> tested;
  List<String> stateName;

  List<int> overall = new List(5);
  List<int> daily = new List(4);
  bool isSortedByTotal = false;
  //StateModel model = StateModel();
  PageController controller;

  @override
  initState() {
    super.initState();
    controller = PageController(initialPage: widget.page == 1 ? 1 : 0);
    updateUI(widget.dailyData, widget.allData);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  void updateUI(dynamic dailyData, dynamic allData) {
    setState(() {
      if (allData == null) {
        return;
      }
      int size = 35;

      total = new List(size);
      deaths = new List(size);
      discharged = new List(size);
      stateName = new List(size);
      tested = new List(size);

      for (int i = 0; i < size; i++) {
        try {
          total[i] = allData[getStateCodeFromIndex(i)]['total']['confirmed']
              .toDouble()
              .toInt();
        } catch (e) {
          print(e);
          total[i] = 0;
        }

        try {
          discharged[i] = allData[getStateCodeFromIndex(i)]['total']
                  ['recovered']
              .toDouble()
              .toInt();
        } catch (e) {
          print(e);
          discharged[i] = 0;
        }

        try {
          deaths[i] = allData[getStateCodeFromIndex(i)]['total']['deceased']
              .toDouble()
              .toInt();
        } catch (e) {
          print(e);
          deaths[i] = 0;
        }

        try {
          tested[i] = allData[getStateCodeFromIndex(i)]['total']['tested']
              .toDouble()
              .toInt();
        } catch (e) {
          print(e);
          tested[i] = 0;
        }

        stateName[i] = getStateNameFromCode(getStateCodeFromIndex(i));
      }

      overall[1] = allData['TT']['total']['recovered'].toDouble().toInt();
      overall[2] = allData['TT']['total']['deceased'].toDouble().toInt();
      overall[0] = allData['TT']['total']['confirmed'].toDouble().toInt();
      overall[4] = allData['TT']['total']['tested'].toDouble().toInt();
      overall[3] = overall[0] - overall[1] - overall[2];

      daily[1] = allData['TT']['delta']['recovered'].toDouble().toInt();
      daily[2] = allData['TT']['delta']['deceased'].toDouble().toInt();
      daily[0] = allData['TT']['delta']['confirmed'].toDouble().toInt();
      daily[3] = daily[0] - daily[1] - daily[2];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeChanger>(
      builder: (context, themeChanger, child) {
        ThemeChanger themeChanger =
            Provider.of<ThemeChanger>(context, listen: false);
        isSortedByTotal = themeChanger.getSortStatus;

        if (isSortedByTotal) {
          sortData(total, 0, total.length - 1);
        } else
          sortDataByAlpha(stateName, 0, stateName.length - 1);

        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.sort_by_alpha),
                tooltip: !isSortedByTotal ? 'Sort by Name' : 'Sort by Total',
                onPressed: () {
                  ThemeChanger themeChanger =
                      Provider.of<ThemeChanger>(context, listen: false);
                  setState(() {
                    if (isSortedByTotal) {
                      sortData(total, 0, total.length - 1);
                      //isSortedByTotal = true;
                      themeChanger.swapSort();
                    } else {
                      sortDataByAlpha(stateName, 0, stateName.length - 1);
                      //isSortedByTotal = false;
                      themeChanger.swapSort();
                    }
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.brightness_6),
                tooltip: 'Switch Theme',
                onPressed: () {
                  ThemeChanger themeChanger =
                      Provider.of<ThemeChanger>(context, listen: false);
                  themeChanger.swapTheme();
                },
              ),
            ],
            title: Hero(
                tag: 'covid19',
                child: Material(
                  //color: Colors.grey[900],
                  color: Colors.transparent,
                  child: Text(
                    'Covid 19',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24),
                  ),
                )),
          ),
          body: ScrollConfiguration(
            behavior: MyBehavior(),
            child: PageView(
              controller: controller,
              children: <Widget>[
                _myListView(context),
                _overallList(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _myListView(BuildContext context) {
    ThemeData _themeData = Provider.of<ThemeChanger>(context).getTheme;
    Color subtitleText = _themeData == ThemeData.light()
        ? Colors.grey.shade900
        : Colors.grey.shade300;
    Color refreshBG = _themeData == ThemeData.light()
        ? Colors.grey.shade300
        : Colors.grey.shade900;
    Color refreshIcon =
        _themeData == ThemeData.light() ? Colors.blue.shade500 : Colors.white;

    return AnimationLimiter(
      child: LiquidPullToRefresh(
        key: Key('states'),
        color: refreshBG,
        backgroundColor: refreshIcon,
        showChildOpacityTransition: false,
        onRefresh: () async {
          await refreshHome(context, 0);
        },
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: stateName.length,
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 310),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    margin: index == 0
                        ? EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 11.0, bottom: 6.0)
                        : index == stateName.length - 1
                            ? EdgeInsets.only(
                                left: 8.0, right: 8.0, top: 6.0, bottom: 12.0)
                            : EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 6.0),
                    child: ListTile(
                      onTap: () {
//                        Scaffold.of(context).showSnackBar(
//                          SnackBar(
//                            content: Text('OK'),
//                          ),
//                        );
                        if (getStateCodeFromName(stateName[index]) != '') {
                          setState(() {
                            Navigator.push(
                              context,
                              MorpheusPageRoute(
                                builder: (context) => DistrictScreen(
                                  //isDistrict: 1,
                                  stateCode:
                                      getStateCodeFromName(stateName[index]),
                                  stateName: stateName[index],
                                  index: index,
                                  allData: widget.allData,
                                ),
                              ),
                            );
                          });
                        }
                      },
                      title: Hero(
                        tag: 'stateName' + index.toString(),
                        child: Material(
                          color: Colors.transparent,
                          child: Text(
                            stateName[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w500),
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      ),
                      subtitle: Text(
                        '\nTotal: ' +
                            total[index].toString() +
                            getDelta('confirmed', index) +
                            '\nRecovered: ' +
                            discharged[index].toString() +
                            getDelta('recovered', index) +
                            '\nDeaths: ' +
                            deaths[index].toString() +
                            getDelta('deceased', index) +
                            '\nActive: ' +
                            (total[index] - discharged[index] - deaths[index])
                                .toString() +
                            '\nTested: ' +
                            tested[index].toString(),
                        style: TextStyle(
                          fontSize: 18,
                          color: subtitleText,
                          letterSpacing: 0.9,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _overallList(BuildContext context) {
    ThemeData _themeData = Provider.of<ThemeChanger>(context).getTheme;
    Color refreshBG = _themeData == ThemeData.light()
        ? Colors.grey.shade300
        : Colors.grey.shade900;
    Color refreshIcon =
        _themeData == ThemeData.light() ? Colors.blue.shade500 : Colors.white;

    return AnimationLimiter(
      child: LiquidPullToRefresh(
        key: Key('overall'),
        color: refreshBG,
        backgroundColor: refreshIcon,
        showChildOpacityTransition: false,
        onRefresh: () async {
          await refreshHome(context, 1);
        },
        child: ListView.builder(
          //physics: BouncingScrollPhysics(),
          itemCount: overall.length,
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 310),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    margin: index == 0
                        ? EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 11.0, bottom: 6.0)
                        : EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
                    child: ListTile(
                      title: Text(
                        index == 0
                            ? 'Total'
                            : index == 1
                                ? 'Recovered'
                                : index == 2
                                    ? 'Deaths'
                                    : index == 3 ? 'Active' : 'Tested',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w400),
                      ),
                      subtitle: Text(
                        index == 3 || index == 4
                            ? overall[index].toString()
                            : overall[index].toString() +
                                ' (+' +
                                daily[index].toString() +
                                ')',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, letterSpacing: 1.1),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future refreshHome(BuildContext context, int pageNo) async {
    DailyDataModel dailyDataModel = DailyDataModel();
    var dailyData = await dailyDataModel.getData();

    AllDataModel allDataModel = AllDataModel();
    var allData = await allDataModel.getData();

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return HomeScreen(
        dailyData: dailyData,
        allData: allData,
        page: pageNo,
      );
    }));
  }

  String getDelta(String type, int index) {
    List data = widget.dailyData['states_daily'];
    int size = data.length;

    int typeNumber = 1;
    if (type == 'confirmed') {
      typeNumber = 3;
    } else if (type == 'recovered') {
      typeNumber = 2;
    } else if (type == 'deceased') {
      typeNumber = 1;
    }
    try {
      if (getStateCodeFromName(stateName[index]) != null &&
          widget.dailyData['states_daily'][size - typeNumber]
                      [getStateCodeFromName(stateName[index]).toLowerCase()]
                  .toString() !=
              '0') {
        String str = '(+' +
            widget.dailyData['states_daily'][size - typeNumber]
                    [getStateCodeFromName(stateName[index]).toLowerCase()]
                .toString() +
            ')';
        return str;
      }
    } catch (e) {
      return '';
    }

    return '';
  }

  void sortData(List<int> arr, int low, int high) {
    if (low < high) {
      int pi = partition(arr, low, high);
      sortData(arr, low, pi - 1);
      sortData(arr, pi + 1, high);
    }
  }

  int partition(List<int> arr, int low, int high) {
    int pivot = arr[high];
    int i = (low - 1);
    for (int j = low; j < high; j++) {
      if (arr[j] > pivot) {
        i++;
        int temp = arr[i];
        arr[i] = arr[j];
        arr[j] = temp;

        int temp2 = deaths[i];
        deaths[i] = deaths[j];
        deaths[j] = temp2;

        int temp3 = discharged[i];
        discharged[i] = discharged[j];
        discharged[j] = temp3;

        String temp4 = stateName[i];
        stateName[i] = stateName[j];
        stateName[j] = temp4;

        int temp5 = tested[i];
        tested[i] = tested[j];
        tested[j] = temp5;
      }
    }

    int temp = arr[i + 1];
    arr[i + 1] = arr[high];
    arr[high] = temp;

    int temp2 = deaths[i + 1];
    deaths[i + 1] = deaths[high];
    deaths[high] = temp2;

    int temp3 = discharged[i + 1];
    discharged[i + 1] = discharged[high];
    discharged[high] = temp3;

    String temp4 = stateName[i + 1];
    stateName[i + 1] = stateName[high];
    stateName[high] = temp4;

    int temp5 = tested[i + 1];
    tested[i + 1] = tested[high];
    tested[high] = temp5;

    return i + 1;
  }

  void sortDataByAlpha(List<String> arr, int low, int high) {
    if (low < high) {
      int pi = partitionAlpha(arr, low, high);
      sortDataByAlpha(arr, low, pi - 1);
      sortDataByAlpha(arr, pi + 1, high);
    }
  }

  int partitionAlpha(List<String> arr, int low, int high) {
    String pivot = arr[high];
    int i = (low - 1);
    for (int j = low; j < high; j++) {
      if (arr[j].compareTo(pivot) < 0) {
        i++;
        String temp = arr[i];
        arr[i] = arr[j];
        arr[j] = temp;

        int temp2 = deaths[i];
        deaths[i] = deaths[j];
        deaths[j] = temp2;

        int temp3 = discharged[i];
        discharged[i] = discharged[j];
        discharged[j] = temp3;

        int temp4 = total[i];
        total[i] = total[j];
        total[j] = temp4;

        int temp5 = tested[i];
        tested[i] = tested[j];
        tested[j] = temp5;
      }
    }

    String temp = arr[i + 1];
    arr[i + 1] = arr[high];
    arr[high] = temp;

    int temp2 = deaths[i + 1];
    deaths[i + 1] = deaths[high];
    deaths[high] = temp2;

    int temp3 = discharged[i + 1];
    discharged[i + 1] = discharged[high];
    discharged[high] = temp3;

    int temp4 = total[i + 1];
    total[i + 1] = total[high];
    total[high] = temp4;

    int temp5 = tested[i + 1];
    tested[i + 1] = tested[high];
    tested[high] = temp5;

    return i + 1;
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
