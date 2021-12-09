import 'package:equatable/equatable.dart';

abstract class QrCheckEvent extends Equatable {
  const QrCheckEvent();
  @override 
  List<Object> get props => [];
}

class QrFound extends QrCheckEvent {
  const QrFound({required this.result});

  final result;

  @override 
  List<Object> get props => [];

}