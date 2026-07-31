import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/trips_dao.dart';
import '../bloc/session_player_cubit.dart';
import '../bloc/session_player_state.dart';
import '../utils/chart_helper.dart';
import '../widgets/charts/charts_tab.dart';
import '../widgets/player/player_tab.dart';

class SessionPlayerScreen extends StatefulWidget {
  final int tripId;
  final TripsDao tripsDao;

  const SessionPlayerScreen({
    super.key,
    required this.tripId,
    required this.tripsDao,
  });

  @override
  State<SessionPlayerScreen> createState() => _SessionPlayerScreenState();
}

class _SessionPlayerScreenState extends State<SessionPlayerScreen> {
  late SessionPlayerCubit _cubit;

  @override
  void initState() {
    super.initState();
    // Initialize Cubit and request to load the session
    _cubit = SessionPlayerCubit(widget.tripsDao)..loadSession(widget.tripId);
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Session Details'),
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.play_circle_outline), text: 'Player'),
                Tab(icon: Icon(Icons.show_chart), text: 'Charts'),
              ],
            ),
          ),
          body: BlocBuilder<SessionPlayerCubit, SessionPlayerState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.errorMessage != null) {
                return Center(
                  child: Text(
                    state.errorMessage!,
                    style: TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                );
              }

              return const TabBarView(
                physics: NeverScrollableScrollPhysics(), // Disable swiping between tabs so it doesn't conflict with the slider/map
                children: [
                  PlayerTab(),
                  ChartsTab(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}