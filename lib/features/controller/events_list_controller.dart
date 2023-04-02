import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:eventos_deportivos/features/data/events_repository.dart';
import 'package:eventos_deportivos/models/ModelProvider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final eventsListControllerProvider = Provider<EventsListController>((ref) {
  return EventsListController(ref);
});

class EventsListController {
  EventsListController(this.ref);
  final Ref ref;

  Future<void> add({
    required String title,
    String? description,
    required String city,
    required String departamento,
    required String date,
    String? punchline1,
    String? punchline2,
    required String categoryID,
    String? eventImageUrl,
    String? eventImageKey
  }) async {
    Event event = Event(
        title: title,
        description: description,
        city: city,
        departamento: departamento,
        //date: TemporalDateTime(DateTime.parse(date).toLocal()),
        date: TemporalDateTime(DateTime.now()),
        //DateFormat('E, d MMM yyyy hh:mm a').format(date),
        punchline1: punchline1,
        punchline2: punchline2,
        categoryID: categoryID,
        eventImageUrl: eventImageUrl,
        eventImageKey: eventImageKey
    );

    final eventsRepository = ref.read(eventsRepositoryProvider);

    await eventsRepository.add(event);
  }
}