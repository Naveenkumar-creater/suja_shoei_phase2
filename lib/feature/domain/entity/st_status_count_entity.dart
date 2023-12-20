import 'package:equatable/equatable.dart';

class SupportTicketStatusEntity extends Equatable {
  final int count;

  const SupportTicketStatusEntity({
    required this.count,
  });

  @override
  List<Object?> get props => [count];
}
