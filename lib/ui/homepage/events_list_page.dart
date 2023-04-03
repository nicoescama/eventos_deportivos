import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:eventos_deportivos/ui/add_event/add_event_page.dart';
import 'package:eventos_deportivos/ui/homepage/event_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:eventos_deportivos/features/data/events_repository.dart';
import 'package:eventos_deportivos/ui/event_details/event_details_page.dart';

import 'package:eventos_deportivos/models/Categoria.dart';

import 'category_widget.dart';

//import 'package:amplify_trips_planner/features/trip/data/trips_repository.dart';
//import 'package:amplify_trips_planner/features/trip/ui/trips_list/add_trip_bottomsheet.dart';
//import 'package:amplify_trips_planner/features/trip/ui/trips_list/trip_card.dart';
//import 'package:amplify_trips_planner/common/utils/colors.dart' as constants;

class EventsListPage extends HookConsumerWidget {
  const EventsListPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    final eventsListValue = ref.watch(eventsListStreamProvider);
    List<Categoria> categories = [
      Categoria(id: "1", name: "natacion", icon: "Icons.sports"), Categoria(id: "2", name: "ciclismo",  icon: "Icons.sports"),
      Categoria(id: "3", name: "MBT", icon: "Icons.sports"), Categoria(id: "4", name: "Senderismo",  icon: "Icons.sports"),
      Categoria(id: "5", name: "Trialtlón", icon: "Icons.sports"), Categoria(id: "6", name: "Espeleología",  icon: "Icons.sports"),
      Categoria(id: "7", name: "Atletismo", icon: "Icons.sports"), Categoria(id: "8", name: "Futbol",  icon: "Icons.sports")];
    return Scaffold(
        backgroundColor: Colors.lightBlueAccent,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Eventos Deportivos',
          ),
          backgroundColor: Colors.blue,
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Authenticator(
                child: MaterialApp(
                  builder: Authenticator.builder(),
                  home: const Scaffold(
                    body: Center(
                      child: AddEventPage(),
                    ),
                  ),
                ),
              ),
            ));
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
        body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child:SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [for (Categoria category in categories) CategoryWidget(categoria: category)],
                ),
              ),
            ),
          eventsListValue.when(
              data: (events) => events.isEmpty
                  ? const Center(
                child: Text('No Trips'),
              )
                  : Expanded(
              child: Column(
                children: [
                  Flexible(
                    child: GridView.count(
                      crossAxisCount:
                      (orientation == Orientation.portrait) ? 1 : 1,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      childAspectRatio:
                      (orientation == Orientation.portrait) ? 1.4 : 1.4,
                      children: events.map((eventData) {
                        return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => EventDetailsPage(event: eventData),
                                ),
                              );//setState(() {}));
                            },
                            child: EventWidget(event: eventData!));
                      }).toList(),
                    ),
                  ),
                ],
              )),
              error: (e, st) => const Center(
                child: Text('Error'),
              ),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ))]

                ));
  }
}