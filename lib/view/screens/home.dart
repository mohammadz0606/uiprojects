import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uiprojects/cubit/agents_cubit.dart';

import '../../data/database_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<AgentsCubit>(context).getAllAgents();
    super.initState();
  }

  @override
  void dispose() {
    DatabaseHelper.instance.close();
    log('dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sqlite"),
      ),
      body: BlocConsumer<AgentsCubit, AgentsState>(
        builder: (context, state) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: _buildUI(context, state),
          );
        },
        listener: (BuildContext context, AgentsState state) {
          if (state is AgentsLoaded) {
            log("Done get data");
          }
        },
      ),
    );
  }
}

Widget _buildUI(BuildContext context, AgentsState state) {
  if (state is AgentsLoading) {
    return const LinearProgressIndicator();
  } else if (state is AgentsLoaded) {
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        await BlocProvider.of<AgentsCubit>(context).getAllAgentsInRefresh();
      },
      child: ListView.builder(
        itemCount: state.agent.length,
        itemBuilder: (context, index) {
          final data = state.agent[index];
          return ListTile(
            title: Text(
              data.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              data.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            leading: CircleAvatar(
              radius: 28,
              backgroundImage: NetworkImage(data.imageUrl),
            ),
          );
        },
      ),
    );
  } else if (state is AgentsError) {
    return Center(
      child: Text(
        state.message,
      ),
    );
  } else {
    return const SizedBox.shrink();
  }
}
