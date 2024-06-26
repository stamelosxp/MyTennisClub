import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mytennisclub/models/calendar.dart';

import '../Database/ConnectionDatabase.dart';

enum CourtType {
  hard,
  clay,
  grass,
}

class Court {
  final int id;
  final String name;
  final CourtType type;
  final bool covered;
  final int athlete_capacity;
  final Calendar? calendar;
  final double price;

  Court({
    required this.id,
    required this.name,
    required this.type,
    required this.covered,
    required this.athlete_capacity,
    required this.price,
    required this.calendar,
  });

  Calendar? getCalendar() {
    return calendar;
  }

  int get courtId {
    return id;
  }

  int get numAthletes {
    return athlete_capacity;
  }

  static Future<Map<int, Map<String, dynamic>>> fetchCourtsAndHours(
      int clubId,
      DateTime date,
      String duration,
      String coachId,
      int numAthletes,
      String? memberIds) async {
    Map<int, Map<String, dynamic>> courtsMap = {};

    // Extracting hours and minutes from the duration string
    String formattedDuration = duration.split(' ')[0]; // Extracts '1:00'
    // print(date);
    // print('clubId $clubId, date $date, formattedDuration  $formattedDuration, coachId $coachId, numAthletes $numAthletes, memberIds $memberIds');
    // print(DateFormat('yyyy-MM-dd').format(date));
    try {
      final conn = await MySQLConnector.createConnection();
      if (conn != null) {
        var results = (await conn
            .query('CALL getAvailableCourts(?, DATE(?), ?, ?, ?, ?);', [
          clubId,
          DateFormat('yyyy-MM-dd').format(date),
          formattedDuration,
          coachId,
          numAthletes,
          memberIds,
        ]));
        print(results);
        for (var row in results) {
          int courtId = row[0];
          if (!courtsMap.containsKey(courtId)) {
            courtsMap[courtId] = {
              'court_id': courtId,
              'court_title': row[1],
              'time_slots': [],
            };
          }

          courtsMap[courtId]?['time_slots'].add({
            'start_time': row[2],
            'end_time': row[3],
          });
        }
        // print(courtsMap.keys.toList());
        // print(courtsMap.values.toList());

        await conn.close();
      }
    } catch (e) {
      throw Exception('Error fetching reservation: $e');
    }

    return courtsMap;
  }
}
