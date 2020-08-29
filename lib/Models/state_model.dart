import '../Utilities/networking.dart';

const url = 'https://api.rootnet.in/covid19-in/stats/latest';

class StateModel {
  Future<dynamic> getData() async {
    NetworkHelper networkHelper = NetworkHelper(url);
    var covidData = await networkHelper.getData();
    return covidData;
  }
}
