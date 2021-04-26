import '../Utilities/networking.dart';

const url = 'https://api.covid19india.org/v4/data.json';

class AllDataModel {
  Future<dynamic> getData() async {
    NetworkHelper networkHelper = NetworkHelper(url);
    var covidData = await networkHelper.getData();
    return covidData;
  }
}
