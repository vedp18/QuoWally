class AutoChangeQuoteValues {

  static Map<int, String> screen = {
    1 : "Lock Screen",
    2 : "Home Screen",
    3 : "Both Screen",
  };


  static Map<Duration, String> quoteChangeInterval = {
    Duration(minutes: 15) : "15 Minutes",
    Duration(hours: 1): "1 Hour",
    Duration(hours: 2): "2 Hours",
    Duration(hours: 4): "4 Hours",
    Duration(hours: 6): "6 Hours",
    Duration(hours: 8): "8 Hours",
    Duration(hours: 12): "12 Hours",
    Duration(hours: 24): "24 Hours",
  };

  // static Map<String, String> quoteList = {
  //   "Quowally Quote List" : "Quowally Quote List",
  // };
}
