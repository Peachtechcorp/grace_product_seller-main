getAgentsFromJson(List<dynamic> orders) =>
    List.generate(orders.length, (index) => Agent.fromJson(orders[index]));

class Agent {
  int id;
  String name;
  int? countryId;
  int? regionId;
  int? districtId;
  int? wardId;
  int? streetId;
  double? latitude;
  double? longitude;

  Agent({
    required this.id,
    required this.name,
    this.countryId,
    this.regionId,
    this.districtId,
    this.wardId,
    this.streetId,
    this.latitude,
    this.longitude,
  });

  factory Agent.fromJson(Map<String, dynamic> json) {
    return Agent(
      id: json['id'],
      name: json['company_name'],
      countryId: json['country_id'],
      regionId: json['region_id'],
      districtId: json['district_id'],
      wardId: json['ward_id'],
      streetId: json['street_id'],
      latitude: double.tryParse(json['latitude']),
      longitude: double.tryParse(json['longitude']),
    );
  }
}
