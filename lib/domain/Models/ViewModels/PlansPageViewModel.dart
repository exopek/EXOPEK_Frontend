import 'package:exopek_workout_app/domain/Models/Plan.dart';

class PlansPageViewModel {
  List<PlanListItem> plans = [];
  List<PlanStatus> planStatuses = [];

  PlansPageViewModel({required this.plans, required this.planStatuses});

  // create empty object
  static PlansPageViewModel empty() {
    return PlansPageViewModel(plans: [], planStatuses: []);
  }

}
