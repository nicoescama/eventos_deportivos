import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:eventos_deportivos/models/Event.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:eventos_deportivos/models/Categoria.dart';

final eventsDataStoreServiceProvider = Provider<EventsDataStoreService>((ref) {
  final service = EventsDataStoreService();
  return service;
});

class EventsDataStoreService {
  EventsDataStoreService();

  Stream<List<Event>> listenToEvents() {
    debugPrint("entra a listenToEvents");
    var prueba = Amplify.DataStore.observeQuery(Event.classType);
      //Event.classType);
    debugPrint(prueba.toString());

    return Amplify.DataStore.observeQuery(
      Event.classType,
      //sortBy: [Event.DATE.ascending()],
    )
        .map((event) => event.items
        //.where((element) =>
        //element.date.getDateTimeInUtc().isBefore(DateTime.now()))
        .toList())
        .handleError(
          (error) {
        debugPrint('listenToEvents: A Stream error happened');
      },
    );
  }

  Stream<List<Event>> listenToPastEvents() {
    return Amplify.DataStore.observeQuery(
      Event.classType,
      sortBy: [Event.DATE.ascending()],
    )
        .map((event) => event.items
        .where((element) =>
        element.date.getDateTimeInUtc().isBefore(DateTime.now()))
        .toList())
        .handleError(
          (error) {
        debugPrint('listenToEvents: A Stream error happened');
      },
    );
  }

  Stream<Event> getEventStream(String id) {
    final eventStream =
    Amplify.DataStore.observeQuery(Event.classType, where: Event.ID.eq(id))
        .map((event) => event.items.toList().single);

    return eventStream;
  }

  Future<void> addEvent(Event event) async {
    try {
      await Amplify.DataStore.save(event);
    } on Exception catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<void> deleteEvent(Event event) async {
    try {
      await Amplify.DataStore.delete(event);
    } on Exception catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<void> updateEvent(Event updatedEvent) async {
    try {
      final eventsWithId = await Amplify.DataStore.query(
        Event.classType,
        where: Event.ID.eq(updatedEvent.id),
      );

      final oldEvent = eventsWithId.first;
      final newEvent = oldEvent.copyWith(
        title: updatedEvent.title,
        description: updatedEvent.description,
        city: updatedEvent.city,
        departamento: updatedEvent.departamento,
        date: updatedEvent.date,
        punchline1: updatedEvent.punchline1,
        punchline2: updatedEvent.punchline2,
        categoryID: updatedEvent.categoryID,
        eventImageUrl: updatedEvent.eventImageUrl,
        eventImageKey: updatedEvent.eventImageKey,
      );

      await Amplify.DataStore.save(newEvent);
    } on Exception catch (error) {
      debugPrint(error.toString());
    }
  }
}