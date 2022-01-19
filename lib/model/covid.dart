class Covid {

  String? city;
  String? ibgeCityCode;
  int? confirmed;
  double? confirmedPer100kInhabitants;
  String? date;
  double? deathRate;
  int? deaths;
  int? estimatedPopulation;
  int? estimatedPopulation2019;
  bool? isLast;
  int? orderForPlace;
  String? placeType;
  String? state;

  Covid({
    this.city,
    this.ibgeCityCode,
    this.confirmed,
    this.confirmedPer100kInhabitants,
    this.date,
    this.deathRate,
    this.deaths,
    this.estimatedPopulation,
    this.estimatedPopulation2019,
    this.isLast,
    this.orderForPlace,
    this.placeType,
    this.state});

  Covid.fromMap(Map<String, dynamic> map) {
    city = map['city'] ?? '';
    ibgeCityCode = map['city_ibge_code'] ?? '';
    confirmed = map['confirmed'] ?? 0;
    confirmedPer100kInhabitants = map['confirmed_per_100k_inhabitants'] ?? 0.0;
    date = map['date'] ?? '';
    deathRate = map['death_rate'] ?? 0.0;
    deaths = map['deaths'] ?? 0;
    estimatedPopulation = map['estimated_population'] ?? 0;
    estimatedPopulation2019 = map['estimated_population_2019'] ?? 0;
    isLast = map['is_last'] ?? false;
    orderForPlace = map['order_for_place'] ?? 0;
    placeType = map['place_type'] ?? '';
    state = map['state'] ?? '';
  }

  @override
  String toString() {
    return 'Covid{city: $city, ibgeCityCode: $ibgeCityCode, confirmed: $confirmed, confirmedPer100kInhabitants: $confirmedPer100kInhabitants, date: $date, deathRate: $deathRate, deaths: $deaths, estimatedPopulation: $estimatedPopulation, estimatedPopulation2019: $estimatedPopulation2019, isLast: $isLast, orderForPlace: $orderForPlace, placeType: $placeType, state: $state}';
  }
}