import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import '../../diagnostic/bloc/diagnostic_bloc.dart';
import '../widgets/dashboard_body.dart';
import '../widgets/diagnostic_banner.dart';

class LiveDashboardTab extends StatefulWidget {
  final String carMake;

  const LiveDashboardTab({
    super.key,
    required this.carMake,
  });

  @override
  State<LiveDashboardTab> createState() => _LiveDashboardTabState();
}

class _LiveDashboardTabState extends State<LiveDashboardTab> {
  @override
  void initState() {
    super.initState();

    context.read<DiagnosticBloc>().add(
      LoadTroubleCodes(widget.carMake),
    );

    WakelockPlus.enable();
  }

  @override
  void dispose() {
    WakelockPlus.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        DiagnosticWarningBanner(),
        Expanded(
          child: DashboardBody(),
        ),
      ],
    );
  }
}