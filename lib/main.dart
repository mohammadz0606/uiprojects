import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uiprojects/data/repository/repo_agents.dart';
import 'package:uiprojects/data/web_service/web_service.dart';

import 'cubit/agents_cubit.dart';
import 'data/database_helper.dart';
import 'view/screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.database;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider<AgentsCubit>(
        create: (context) => AgentsCubit(
          repoAgents: RepoAgents(
            webService: WebService(),
          ),
        ),
        child: const HomeScreen(),
      ),
    );
  }
}
