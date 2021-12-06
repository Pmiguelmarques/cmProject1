import 'package:hive/hive.dart';
import 'package:gym_app/data/model/event.dart';
import 'package:gym_app/data/model/client.dart';

class Boxes {
  static Box<Event> getEvents() => Hive.box<Event>('event');

  static bool isFav(Client c, Event e){
    var favEvents = c.events;
    for(var i = 0; i < c.events.length; i++){
        if(e.key == c.events[i].key){
          return true;
        }
    }
    return false;
  }

  static Event getEventAt(int index) {
    var temp = Hive.box<Event>('event').getAt(index);
    if(temp!=null){
      return temp;
    }else{
      final defaultEvent = Event()
      ..name = "default"
      ..teacher = "default"
      ..lat = 404
      ..long = 404
      ..data = "default"
      ..maxCapacity = 404;
      return defaultEvent;
    }
    
  } 

  static Box<Client> getClients() => Hive.box<Client>('client');

  
  static Client getClient(String password) {
    var temp = Hive.box<Client>('client').get(password);
    if(temp != null){
      return temp;
    }else{
      final defaultClient = Client()
      ..firstName = "default"
      ..lastName = "default"
      ..userName = "default"
      ..password = "default"
      ..isTrainer = false
      ..events = [];
      return defaultClient;
    }
  } 
}