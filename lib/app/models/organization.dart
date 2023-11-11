import 'package:grace_product_seller/app/models/agent.dart';

getOrganizationsFromJson(List<dynamic> orders) => List.generate(
    orders.length, (index) => Organization.fromJson(orders[index]));

class Organization {
  int id;
  int teamId;
  String name;
  int typeId;
  List<Agent> agents;

  Organization({
    required this.id,
    required this.teamId,
    required this.name,
    required this.typeId,
    required this.agents,
  });

  factory Organization.fromJson(Map<String, dynamic> json) {
    List<Agent> agents = [];

    if (json.containsKey('agents')) {
      agents = getAgentsFromJson(json['agents']);
    }

    return Organization(
      id: json['id'],
      teamId: json['team_id'],
      name: json['name'],
      typeId: json['organization_type_id'],
      agents: agents,
    );
  }
}
