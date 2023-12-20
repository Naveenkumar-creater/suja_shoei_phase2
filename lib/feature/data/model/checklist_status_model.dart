import '../../domain/entity/checklist_status_count_entity.dart';

class ChecklistStatusModel extends ChecklistStatusEntity {
  const ChecklistStatusModel({
    required int count,
  }) : super(count: count);

  factory ChecklistStatusModel.fromJson(Map<String, dynamic> json) {
    final checklistStatus = json['response_data']['checklist_status'];
    return ChecklistStatusModel(
      count: checklistStatus['count'],
    );
  }
}
