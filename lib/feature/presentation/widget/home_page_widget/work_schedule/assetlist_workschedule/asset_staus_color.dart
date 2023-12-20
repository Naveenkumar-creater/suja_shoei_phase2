import 'package:flutter/material.dart';

class AssetStatusColor {
  String getStatusText(int checklistStatus, String inspection) {
    DateTime now = DateTime.now();

    // Parse the inspection string into a DateTime object
    DateTime amSupTicketDate = DateTime.parse(inspection);

    // Extract the date part as a string in "yyyy-MM-dd" format
    String amSupTicketDateStr =
        "${amSupTicketDate.year}-${amSupTicketDate.month.toString().padLeft(2, '0')}-${amSupTicketDate.day.toString().padLeft(2, '0')}";
    String nowDateStr =
        "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

    // Compare checklistStatus and the inspection date
    if (checklistStatus == 1 && amSupTicketDateStr == nowDateStr) {
      return "Open";
    } else if (checklistStatus == 2) {
      return "In Progress";
    } else if (checklistStatus == 3 || checklistStatus == 4) {
      return "Complete";
    } else if (checklistStatus == 5) {
      return "Rejected";
    } else {
      return "Overdue";
    }
  }

  Color getStatusColor(int checklistStatus, String inspection) {
    DateTime now = DateTime.now();

    // Parse the inspection string into a DateTime object
    DateTime inspectiondate = DateTime.parse(inspection);

    // Extract the date part as a string in "yyyy-MM-dd" format
    String inspectiondateStr =
        "${inspectiondate.year}-${inspectiondate.month.toString().padLeft(2, '0')}-${inspectiondate.day.toString().padLeft(2, '0')}";
    String nowDateStr =
        "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

    // Compare checklistStatus and the inspection date
    if (checklistStatus == 1 && inspectiondateStr == nowDateStr) {
      return Colors.blue;
    } else if (checklistStatus == 2) {
      return Colors.orange;
    } else if (checklistStatus == 3 || checklistStatus == 4) {
      return Colors.green;
    } else if (checklistStatus == 5) {
      return Colors.black;
    } else {
      return Colors.red;
    }
  }
}

class SupportTicketStatusColor {
  String getsupportticketStatusText(int amSupTicketStatus, String inspection) {
    DateTime now = DateTime.now();

    // Parse the inspection string into a DateTime object
    DateTime amSupTicketDate = DateTime.parse(inspection);

    // Extract the date part as a string in "yyyy-MM-dd" format
    String amSupTicketDateStr =
        "${amSupTicketDate.year}-${amSupTicketDate.month.toString().padLeft(2, '0')}-${amSupTicketDate.day.toString().padLeft(2, '0')}";
    String nowDateStr =
        "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

    // Compare checklistStatus and the inspection date
    if (amSupTicketStatus == 1 && amSupTicketDateStr != nowDateStr) {
      return "Open";
    } else if (amSupTicketStatus == 2) {
      return "In Progress";
    } else if (amSupTicketStatus == 3 || amSupTicketStatus == 4) {
      return "Complete";
    } else if (amSupTicketStatus == 5) {
      return "Rejected";
    } else {
      return "Overdue";
    }
  }

  Color getsupportticketStatusColor(int amSupTicketStatus, String inspection) {
    DateTime now = DateTime.now();

    // Parse the inspection string into a DateTime object
    DateTime amSupTicketDate = DateTime.parse(inspection);

    // Extract the date part as a string in "yyyy-MM-dd" format
    String amSupTicketDateStr =
        "${amSupTicketDate.year}-${amSupTicketDate.month.toString().padLeft(2, '0')}-${amSupTicketDate.day.toString().padLeft(2, '0')}";
    String nowDateStr =
        "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

    // Compare amSupTicketStatus and the inspection date
    if (amSupTicketStatus == 1 && amSupTicketDateStr != nowDateStr) {
      return Colors.blue;
    } else if (amSupTicketStatus == 2) {
      return Colors.orange;
    } else if (amSupTicketStatus == 3 || amSupTicketStatus == 4) {
      return Colors.green;
    } else if (amSupTicketStatus == 5) {
      return Colors.black;
    } else {
      return Colors.red;
    }
  }
}
