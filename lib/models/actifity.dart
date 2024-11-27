class Activity {
  final String id;
  final double distance;
  final int steps;
  final double calories;
  final String duration; // Format: HH:mm:ss
  final DateTime date;

  Activity({
    required this.id,
    required this.distance,
    required this.steps,
    required this.calories,
    required this.duration,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'distance': distance,
        'steps': steps,
        'calories': calories,
        'duration': duration,
        'date': date.toIso8601String(),
      };

  static Activity fromJson(Map<String, dynamic> json) => Activity(
        id: json['id'],
        distance: json['distance'],
        steps: json['steps'],
        calories: json['calories'],
        duration: json['duration'],
        date: DateTime.parse(json['date']),
      );
}
