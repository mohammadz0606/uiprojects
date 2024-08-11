import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:uiprojects/data/model/agents/agent.dart';

import '../data/database_helper.dart';
import '../data/model/home.dart';
import '../data/repository/repo_agents.dart';

part 'agents_state.dart';

class AgentsCubit extends Cubit<AgentsState> {
  AgentsCubit({required this.repoAgents}) : super(AgentsInitial());

  final RepoAgents repoAgents;

  Future<void> getAllAgents() async {
    try {
      emit(AgentsLoading());
      if (await DatabaseHelper.instance.isAgentsTableEmpty()) {
        log('is enter');
        await _getAllAgentsRepo();
      }
      List<HomeModel> list = await _fetchAgents();
      emit(AgentsLoaded(agent: list));
    } catch (e) {
      emit(AgentsError(message: e.toString()));
    }
  }

  Future<void> getAllAgentsInRefresh() async {
    try {
      emit(AgentsLoading());
      await _getAllAgentsRepo();
      List<HomeModel> list = await _fetchAgents();
      emit(AgentsLoaded(agent: list));
    } catch (e) {
      emit(AgentsError(message: e.toString()));
    }
  }

  Future<Agent> _getAllAgentsRepo() {
    try {
      return repoAgents.getAllAgents();
    } catch (e) {
      return Future.error('Failed to fetch agents: $e');
    }
  }

  Future<List<HomeModel>> _fetchAgents() async {
    final db = await DatabaseHelper.instance.database;

    final result = await db?.query('agents');

    if (result != null) {
      return result.map((json) => HomeModel.fromJson(json)).toList();
    } else {
      return [];
    }
  }
}
