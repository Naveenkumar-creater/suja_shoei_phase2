class ChecklistStatus {
  List<ChecklistStatusCount>? checklistStatusCount;

  ChecklistStatus({this.checklistStatusCount});

  ChecklistStatus.fromJson(Map<String, dynamic> json) {
    if (json['checklist_status_count'] != null) {
      checklistStatusCount = <ChecklistStatusCount>[];
      json['checklist_status_count'].forEach((v) {
        checklistStatusCount!.add(ChecklistStatusCount.fromJson(v));
      });
    }
  }
}

class ChecklistStatusCount {
  int? checklistOpensCount;
  int? checklistInProgressCount;
  int? checklistCompleteCount;
  int? checklistOverdueCount;

  ChecklistStatusCount({
    this.checklistOpensCount,
    this.checklistInProgressCount,
    this.checklistCompleteCount,
    this.checklistOverdueCount,
  });

  ChecklistStatusCount.fromJson(Map<String, dynamic> json) {
    checklistOpensCount = json['checklist_opens_count'];
    checklistInProgressCount = json['checklist_inprogross_count'];
    checklistCompleteCount = json['checklist_complete_count'];
    checklistOverdueCount = json['checklist_overDue_count'];
  }
}
