String getStateCodeFromIndex(int index) {
  switch (index) {
    case 0:
      return 'AN';
    case 1:
      return 'AP';
    case 2:
      return 'AR';
    case 3:
      return 'AS';
    case 4:
      return 'BR';
    case 5:
      return 'CH';
    case 6:
      return 'CT';
    case 7:
      return 'DN';
    case 8:
      return 'DL';
    case 9:
      return 'GA';
    case 10:
      return 'GJ';
    case 11:
      return 'HR';
    case 12:
      return 'HP';
    case 13:
      return 'JK';
    case 14:
      return 'JH';
    case 15:
      return 'KA';
    case 16:
      return 'KL';
    case 17:
      return 'LA'; //Ladakh
    case 18:
      return 'MP';
    case 19:
      return 'MH';
    case 20:
      return 'MN';
    case 21:
      return 'ML';
    case 22:
      return 'MZ';
    case 23:
      return 'NL';
    case 24:
      return 'OR';
    case 25:
      return 'PY';
    case 26:
      return 'PB';
    case 27:
      return 'RJ';
    case 28:
      return 'SK';
    case 29:
      return 'TN';
    case 30:
      return 'TG';
    case 31:
      return 'TR';
    case 32:
      return 'UT';
    case 33:
      return 'UP';
    case 34:
      return 'WB';
  }
  return '';
}

String getStateCodeFromName(String name) {
  switch (name) {
    case 'Andaman and Nicobar Islands':
      return 'AN';
    case 'Andhra Pradesh':
      return 'AP';
    case 'Arunachal Pradesh':
      return 'AR';
    case 'Assam':
      return 'AS';
    case 'Bihar':
      return 'BR';
    case 'Chandigarh':
      return 'CH';
    case 'Chhattisgarh':
      return 'CT';
    case 'Dadra and Nagar Haveli and Daman and Diu':
      return 'DN';
    case 'Delhi':
      return 'DL';
    case 'Goa':
      return 'GA';
    case 'Gujarat':
      return 'GJ';
    case 'Haryana':
      return 'HR';
    case 'Himachal Pradesh':
      return 'HP';
    case 'Jammu and Kashmir':
      return 'JK';
    case 'Jharkhand':
      return 'JH';
    case 'Karnataka':
      return 'KA';
    case 'Kerala':
      return 'KL';
    case 'Ladakh':
      return 'LA'; //Ladakh
    case 'Madhya Pradesh':
      return 'MP';
    case 'Maharashtra':
      return 'MH';
    case 'Manipur':
      return 'MN';
    case 'Meghalaya':
      return 'ML';
    case 'Mizoram':
      return 'MZ';
    case 'Nagaland':
      return 'NL';
    case 'Odisha':
      return 'OR';
    case 'Puducherry':
      return 'PY';
    case 'Punjab':
      return 'PB';
    case 'Rajasthan':
      return 'RJ';
    case 'Sikkim':
      return 'SK';
    case 'Tamil Nadu':
      return 'TN';
    case 'Telangana':
      return 'TG';
    case 'Tripura':
      return 'TR';
    case 'Uttarakhand':
      return 'UT';
    case 'Uttar Pradesh':
      return 'UP';
    case 'West Bengal':
      return 'WB';
  }
  return '';
}
