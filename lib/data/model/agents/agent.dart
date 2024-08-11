import 'datum.dart';

class Agent {
  int status;
  List<Datum> data;

  Agent({
    required this.status,
    required this.data,
  });

  factory Agent.fromJson(Map<String, dynamic> json) => Agent(
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}