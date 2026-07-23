abstract class AnalyticsEvent {}

class LoadAnalyticsData extends AnalyticsEvent {
  final int carId;
  LoadAnalyticsData(this.carId);
}