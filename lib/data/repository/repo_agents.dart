import 'package:uiprojects/data/web_service/web_service.dart';

import '../model/agents/agent.dart';

final class RepoAgents {
  WebService webService;

  RepoAgents({
    required this.webService,
  });

  Future<Agent> getAllAgents() async {
    try {
      return webService.getAllAgents();
    } catch (e) {
      rethrow;
    }
  }
}
