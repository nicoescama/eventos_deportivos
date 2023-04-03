import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:eventos_deportivos/ui/add_event/add_event_page.dart';
import 'package:eventos_deportivos/ui/homepage/events_list_page.dart';
import 'package:flutter/material.dart';
import 'package:eventos_deportivos/models/Categoria.dart';
import 'package:eventos_deportivos/models/Event.dart';
import 'package:eventos_deportivos/common/utils/styleguide.dart';
import 'package:eventos_deportivos/ui/event_details/event_details_page.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart';

//import 'package:eventos_deportivos/app_state.dart';
import 'package:eventos_deportivos/features/data/events_repository.dart';
import 'package:eventos_deportivos/common/navigation/routes.dart';
import 'category_widget.dart';
import 'event_widget.dart';
import 'home_page_background.dart';

import 'package:amplify_authenticator/amplify_authenticator.dart';

class HomePage extends StatelessWidget  {

  const HomePage({
    required this.isAmplifySuccessfullyConfigured,
    Key? key,
  }) : super(key: key);

  final bool isAmplifySuccessfullyConfigured;

  @override
  Widget build(BuildContext context) {

    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          name: AppRoute.home.name,
          builder: (context, state) => isAmplifySuccessfullyConfigured
              ? const EventsListPage()
              : const Scaffold(
            body: Center(
              child: Text(
                'Tried to reconfigure Amplify; '
                    'this can occur when your app restarts on Android.',
              ),
            ),
          ),
        ),
      ],
      errorBuilder: (context, state) => Scaffold(
        body: Center(
          child: Text(state.error.toString()),
        ),
      ),
    );
    return Authenticator(
      child: MaterialApp.router(
        routeInformationParser: router.routeInformationParser,
        routeInformationProvider: router.routeInformationProvider,
        routerDelegate: router.routerDelegate,
        builder: Authenticator.builder(),
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
   /*

    final Orientation orientation = MediaQuery.of(context).orientation;
    final eventsListValue = ref.watch(eventsListStreamProvider);
    debugPrint(eventsListValue.value.toString());

    return Scaffold(
        body: eventsListValue.when(
          data: (events) =>
          events.isEmpty
              ? const Center(
            child: Text('No hay eventos'),
          )
              : /* Stack(
            children: <Widget>[
              HomePageBackground(
                screenHeight: MediaQuery
                    .of(context)
                    .size
                    .height,
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
                                    builder: (context) =>
                                        Authenticator(
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
                                );
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
                    ),*/
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children:
                          events.map((eventData) {
                            return
                              const Center(
                                child: Text("sirve"),
                              );
                            /*GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EventDetailsPage(event: eventData!),
                                  ),
                                ); //setState(() {}));
                              },
                              child: EventWidget(
                                  event: eventData!
                              ),
                            );*/
                          }).toList(),
                        ),
                      ),
                    /*],
                  ),
                ),
              ),
            ],
          ), */
          error: (e, st) =>
            Center(child: ElevatedButton(
             onPressed: () { debugPrint(st.toString()); },
             child: Text("error"),
         )),
          loading: () =>
          const Center(
            child: CircularProgressIndicator(),
          ),
        ));
         }

    */

/*
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
*/



