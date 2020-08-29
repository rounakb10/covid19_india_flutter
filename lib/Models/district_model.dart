import '../Utilities/networking.dart';

const url = 'https://api.covid19india.org/v2/state_district_wise.json';

class DistrictModel {
  Future<dynamic> getData() async {
    NetworkHelper networkHelper = NetworkHelper(url);
    var covidData = await networkHelper.getData();
    return covidData;
  }
}