import 'package:equatable/equatable.dart';

enum QrCheckStatus {scanning, success, failed, denied}

class QrCheckState extends Equatable {

  const QrCheckState({
    this.status = QrCheckStatus.scanning,
  });

  final QrCheckStatus status;

  QrCheckState copyWith({
    QrCheckStatus? status
  }) {
    return QrCheckState(
      status: status ?? this.status
    );
  }

  @override
  List<Object?> get props => [status];
}