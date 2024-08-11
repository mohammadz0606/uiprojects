import 'package:sqflite/sqflite.dart';
import 'package:uiprojects/constant/constants.dart';
import 'package:uiprojects/data/model/agents/agent.dart';
import 'package:uiprojects/data/model/home.dart';
import 'package:uiprojects/data/web_service/api_service.dart';

import '../database_helper.dart';

final class WebService {
  final APIService _apiService = APIService.instance;

  Future<Agent> getAllAgents() async {
    try {
      Map<String, dynamic> result = await _apiService.makeRequest(
        apiMethod: APIMethods.get,
        codedPath: Constants.agentsMethod,
      );
      Agent agent = Agent.fromJson(result);
      for (var data in agent.data) {
        _insertAgents(
          HomeModel(
            id: data.uuid,
            title: data.displayName,
            description: data.description,
            imageUrl: data.displayIcon,
          ),
        );
      }
      return agent;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _insertAgents(HomeModel home) async {
    final db = await DatabaseHelper.instance.database;
    await db?.insert(
      'agents',
      home.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
