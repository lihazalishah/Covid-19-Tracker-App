# Covid-19 Tracker APP with api Intergation

A new Flutter project.

## Features 

1) splash screen
2) Home screen with world stat of covid-19 throught Api intergation
3) COUNTRIES list also country wise tracking for covid-19

Api of the project
-class AppUrl {
  //base url
  static const String baseUrl = 'https://disease.sh/v3/covid-19/';
  //fatch world covid state
  static const String worldStateApi = baseUrl + 'all';
  static const String countriesList = baseUrl + 'countries';
}


For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
