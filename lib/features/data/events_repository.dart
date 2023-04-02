import 'package:eventos_deportivos/features/services/events_datastore_service.dart';
import 'package:eventos_deportivos/models/Event.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final eventsRepositoryProvider = Provider<EventsRepository>((ref) {
  EventsDataStoreService eventsDataStoreService =
  ref.read(eventsDataStoreServiceProvider);
  return EventsRepository(eventsDataStoreService);
});

final tripsListStreamProvider = StreamProvider.autoDispose<List<Event?>>((ref) {
  final tripsRepository = ref.watch(eventsRepositoryProvider);
  return tripsRepository.getTrips();
});

final pastTripsListStreamProvider =
StreamProvider.autoDispose<List<Event?>>((ref) {
  final tripsRepository = ref.watch(eventsRepositoryProvider);
  return tripsRepository.getPastTrips();
});

final tripProvider =
StreamProvider.autoDispose.family<Event?, String>((ref, id) {
  final tripsRepository = ref.watch(eventsRepositoryProvider);
  return tripsRepository.get(id);
});

class EventsRepository {
  EventsRepository(this.eventsDataStoreService);

  final EventsDataStoreService eventsDataStoreService;

  Stream<List<Event>> getTrips() {
    return eventsDataStoreService.listenToEvents();
  }

  Stream<List<Event>> getPastTrips() {
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