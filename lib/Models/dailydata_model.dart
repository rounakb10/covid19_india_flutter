import '../Utilities/networking.dart';

const url = 'https://api.covid19india.org/states_daily.json';

class DailyDataModel {
  Future<dynamic> getData() async {
    NetworkHelper networkHelper = NetworkHelper(url);
    var covidData = await networkHelper.getData();

    return covidData;
  }
}
