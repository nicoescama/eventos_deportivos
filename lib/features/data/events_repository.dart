import 'package:eventos_deportivos/features/services/events_datastore_service.dart';
import 'package:eventos_deportivos/models/Event.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final eventsRepositoryProvider = Provider<EventsRepository>((ref) {
  EventsDataStoreService eventsDataStoreService =
  ref.read(eventsDataStoreServiceProvider);
  return EventsRepository(eventsDataStoreService);
});

final eventsListStreamProvider = StreamProvider.autoDispose<List<Event?>>((ref) {
  final eventsRepository = ref.watch(eventsRepositoryProvider);
  return eventsRepository.getPastEvents();
});

final pastEventsListStreamProvider =
StreamProvider.autoDispose<List<Event?>>((ref) {
  final eventsRepository = ref.watch(eventsRepositoryProvider);
  return eventsRepository.getPastEvents();
});

final eventProvider =
StreamProvider.autoDispose.family<Event?, String>((ref, id) {
  final eventsRepository = ref.watch(eventsRepositoryProvider);
  return eventsRepository.get(id);
});

class EventsRepository {
  EventsRepository(this.eventsDataStoreService);

  final EventsDataStoreService eventsDataStoreService;

  Stream<List<Event>> getEvents() {
    return eventsDataStoreService.listenToEvents();
  }

  Stream<List<Event>> getPastEvents() {
    return eventsDataStoreService.listenToPastEvents();
  }

  Future<void> add(Event event) async {
    await eventsDataStoreService.addEvent(event);
  }

  Future<void> update(Event updatedEvent) async {
    await eventsDataStoreService.updateEvent(updatedEvent);
  }

  Future<void> delete(Event deletedEvent) async {
    await eventsDataStoreService.deleteEvent(deletedEvent);
  }

  Stream<Event> get(String id) {
    return eventsDataStoreService.getEventStream(id);
  }
}