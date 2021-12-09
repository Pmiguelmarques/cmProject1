import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/data/repository.dart';
import 'package:gym_app/logic/teacher_events/teacher_event_bloc.dart';
import 'package:gym_app/logic/teacher_events/teacher_event_event.dart';
import 'package:gym_app/logic/teacher_events/teacher_event_state.dart';
import 'package:gym_app/widget/bottom_loader.dart';
import 'package:gym_app/widget/event_list_item.dart';
import 'package:gym_app/widget/teacher_page/teacher_event_item.dart';

class TeacherEvents extends StatefulWidget {

  TeacherEvents({required this.username});

  final username;

  @override 
  TeacherEventListState createState() => TeacherEventListState(username: username);
}

class TeacherEventListState extends State<TeacherEvents> {

  TeacherEventListState({required this.username});

  final username;

  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TeacherEventBloc(repository: const Repository())..add(TeacherEventFetched(username)),
      child: BlocBuilder<TeacherEventBloc, TeacherEventState>(
        builder: (context, state) {
          switch(state.status) {
            case TeacherEventStatus.failure:
              return const Center(child: Text('Failed to fetch events'));
            case TeacherEventStatus.success: 
              if(state.events.isEmpty){
                return const Center(child: Text('No posts available'));
              }
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return index >= state.events.length
                        ? const BottomLoader()
                        : TeacherEventItem(event: state.events[index]);
                },
                itemCount: state.hasReachedMax
                          ? state.events.length
                          : state.events.length + 1,
                controller: scrollController,
              );            
            
           default:
            return const Center(child: CircularProgressIndicator()); 
          }
        }
      )
    );
  }

  @override 
  void dispose() {
    scrollController..removeListener(onScroll)..dispose();
    super.dispose();
  }

  void onScroll() {
    if(isBottom) context.read<TeacherEventBloc>().add(TeacherEventFetched(username));
  }

  bool get isBottom {
    if(!scrollController.hasClients) return false;
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}