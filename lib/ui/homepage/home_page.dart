import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:eventos_deportivos/ui/add_event/add_event_page.dart';
import 'package:flutter/material.dart';
import 'package:eventos_deportivos/models/categoria.dart';
import 'package:eventos_deportivos/models/event.dart';
import 'package:eventos_deportivos/common/utils/styleguide.dart';
import 'package:eventos_deportivos/ui/event_details/event_details_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart';

import '../../app_state.dart';
import 'category_widget.dart';
import 'event_widget.dart';
import 'home_page_background.dart';

import 'package:amplify_authenticator/amplify_authenticator.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({
    super.key,
  });
  // Define a key to access the form
  final _formKey = GlobalKey<FormState>();

  List<Categoria> categories = [];
  List<Event> events = [];


  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    super.dispose();
  }

  @override
  initState() {
    //Amplify.DataStore.clear();
    Amplify.DataStore.start();
    queryCategorias();
    queryEvents();
  }


  @override
  Widget build(BuildContext context) {
    final eventsListValue = ref.watch(tripsListStreamProvider);

    return Scaffold(
      body: ChangeNotifierProvider<AppState>(
        create: (_) => AppState(),
        child: Stack(
          children: <Widget>[
            HomePageBackground(
              screenHeight: MediaQuery.of(context).size.height,
            ),
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Row(
                        children: <Widget>[
                          Spacer(),
                          GestureDetector(
                            onTap: () {
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
                                ),
                              ).then((_) => queryEvents());
                            },
                            child: Row(
                          children: <Widget>[
                      Text("Agregar evento",
                              style: fadedTextStyle,
                            ),
                            const Icon(Icons.add, color: Colors.white),
                            ],
                          ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Text(
                        "EVENTOS DEPORTIVOS:",
                        style: whiteHeadingTextStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      child: Consumer<AppState>(
                        builder: (context, appState, _) => SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: <Widget>[for (Categoria category in categories) CategoryWidget(categoria: category)],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Consumer<AppState>(
                        builder: (context, appState, _) => Column(
                          children: <Widget>[
                            //for (final event in events.where((e) => e.categoryIds.contains(appState.selectedCategoryId)))
                            for (final event in events)
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => EventDetailsPage(event: event),
                                    ),
                                  );//setState(() {}));
                                },
                                child: EventWidget(
                                  event: event,
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24.0),
                        child: eventsListValue.when(
                          data: (trips) => trips.isEmpty
                              ? const Center(
                            child: Text('No Trips'),
                          )
                              : Column(
                            children: [
                              Flexible(
                                child: GridView.count(
                                  crossAxisCount:
                                  (orientation == Orientation.portrait) ? 2 : 3,
                                  mainAxisSpacing: 4,
                                  crossAxisSpacing: 4,
                                  padding: const EdgeInsets.all(4),
                                  childAspectRatio:
                                  (orientation == Orientation.portrait) ? 0.9 : 1.4,
                                  children: trips.map((tripData) {
                                    return TripCard(trip: tripData!);
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                    )

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> queryCategorias() async {
    Amplify.DataStore.start();
    try {
      categories = await Amplify.DataStore.query(Categoria.classType);
      //await Amplify.DataStore.save(nuevaCat);
      debugPrint("entra a queryCategorias");
      debugPrint("${categories.length}");
    } catch (e) {
      print("Could not query DataStore: $e");
    }
    setState(() { });
  }

  Future<void> queryEvents() async {
    Amplify.DataStore.start();
    try {
      events = await Amplify.DataStore.query(Event.classType);
      debugPrint("entra a queryEvents");
      debugPrint("${events.length}");
    } catch (e) {
      print("Could not query DataStore: $e");
    }
    setState(() { });
  }

}
