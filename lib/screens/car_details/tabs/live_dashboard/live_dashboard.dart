import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:obd_ledger/screens/car_details/tabs/live_dashboard/widgets/dash_board_body.dart';
import 'package:obd_ledger/screens/car_details/tabs/live_dashboard/widgets/diagnostic_banner.dart';

import '../../../../blocs/diagnostic/diagnostic_bloc.dart';
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