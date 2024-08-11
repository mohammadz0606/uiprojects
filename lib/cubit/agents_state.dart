part of 'agents_cubit.dart';

@immutable
sealed class AgentsState {}

final class AgentsInitial extends AgentsState {}

final class AgentsLoading extends AgentsState {}

final class AgentsLoaded extends AgentsState {
  final List<HomeModel> agent;

  AgentsLoaded({
    required this.agent,
  });
}

final class AgentsError extends AgentsState {
  final String message;

  AgentsError({
    required this.message,
  });
}
