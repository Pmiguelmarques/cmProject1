import 'package:gym_app/data/model/client.dart';
import 'package:gym_app/data/model/event.dart';
import 'package:gym_app/data/provider.dart';

class Repository {

  const Repository();

  Future<List<Event>> getAllEvents() async {
    final rawEvents = await DatabaseProvider.getEvents();
    List<Event> filteredEvents = await DatabaseProvider.fromJsonToEvents(rawEvents);
    return filteredEvents;
  }

  Future<Event> getEvent(String name) async {
    final rawEvent = await DatabaseProvider.getEvent(name);
    Event filteredEvent = await DatabaseProvider.fromJsonToEvent(rawEvent);
    return filteredEvent;
  }

  Future<Client> getClient(String username) async {
    final rawClient = await DatabaseProvider.getClient(username);
    Client filteredClient = await DatabaseProvider.fromJsonToClient(rawClient);
    return filteredClient;
  }

  Future<String> insertEvent(String name, String teacher, double lat, double long, String data) async {
    String result = await DatabaseProvider.addEvent(name, teacher, lat, long, data);
    return result;
  }

  Future<String> insertUser(String firstName, String lastName, String userName, String password, bool isTrainer) async {
    String result = await DatabaseProvider.addUser(firstName, lastName, userName, password, isTrainer);
    return result;
  }

  Future<String> checkLogIn(String username, String password) async {
    final client = await DatabaseProvider.getClient(username);
    if(client['password'] == password){
      print(client['isTrainer']);
      if(client['isTrainer']) {
        return "successTrainer";
      } else {
        return "successUser";
      }
    }
    return "failure"; 
  }

  Future<void> registerClientInEvent(String userName, String eventName) async {
    await DatabaseProvider.registerClientInEvent(userName, eventName);
  }

  Future<void> unregisterClientFromEvent(String userName, String eventName) async {
    await DatabaseProvider.unregisterClientFromEvent(userName, eventName);
  }
}

/*

Future<List<Event>> getAllEventsByName(String name) async {
    final rawEvents = await DatabaseProvider.getEventsByName(name);
    List<Event> filteredEvents = await DatabaseProvider.fromJsonToEvent(rawEvents);
    return filteredEvents;

  }
*/