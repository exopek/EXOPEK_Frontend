abstract class IPlanRepository {
  Future<List<dynamic>> getPlans();
  Future<dynamic> getPlan(String id);
}
