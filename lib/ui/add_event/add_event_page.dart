
import 'dart:ffi';
import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:eventos_deportivos/features/controller/events_list_controller.dart';
import 'package:eventos_deportivos/models/Categoria.dart';
import 'package:eventos_deportivos/models/Event.dart';

import 'package:eventos_deportivos/features/controller/event_controller.dart';

class AddEventPage extends StatefulHookConsumerWidget {

  const AddEventPage({Key? key}) : super(key: key);

  @override
  _AddEventPage createState() => _AddEventPage();
}

class _AddEventPage extends ConsumerState<AddEventPage> {
  // Define a key to access the form
  final _formKey = GlobalKey<FormState>();

  final dateTimeController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  String _title = '';
  String _description = '';
  String _city = '';
  String _departamento = '';
  String _country = '';
  String _punchLine1 = '';
  String _punchLine2 = '';
  //List _categories = [0];
  //List _galleryImages = [];
  List<XFile>? _imageFileList = [];
  String? _eventImageUrl = '';
  String? _eventImageKey = '';
  String _date = '' ;
  String? _selectedCategory = null;


  /*List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("USA"),value: "USA"),
    DropdownMenuItem(child: Text("Canada"),value: "Canada"),
    DropdownMenuItem(child: Text("Brazil"),value: "Brazil"),
    DropdownMenuItem(child: Text("England"),value: "England"),
  ];*/
  List<DropdownMenuItem<String>> menuItems = [];





  // This function is triggered when the user press the "Sign Up" button
  Future<void> _trySubmitForm() async {
    final bool? isValid = _formKey.currentState?.validate();
    if (isValid == true && _imageFileList!.isNotEmpty) {
      debugPrint('Everything looks good!');
      debugPrint(_title);
      debugPrint(_description);
      debugPrint(_city);
      debugPrint(_departamento);
      debugPrint(dateTimeController.text);
      debugPrint(_punchLine1);
      debugPrint(_punchLine2);
      debugPrint(_selectedCategory);
      debugPrint(_eventImageUrl);
      debugPrint(_eventImageKey);

      List imageInfo = await ref.read(eventControllerProvider).uploadFile(File(_imageFileList![0].path));

      await ref.read(eventsListControllerProvider).add(
        title: _title,
        description: _description,
        city: _city,
        departamento: _departamento,
        //date: dateTimeController.text,
          date: _date,
        punchline1: _punchLine1,
        punchline2: _punchLine2,
        categoryID: _selectedCategory!,
        eventImageUrl: imageInfo[1],
        eventImageKey:  imageInfo[0]
      );

      //Navigator.of(context).pop();
      Navigator.of(context, rootNavigator: true).pop(context);



    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    dateTimeController.dispose();
    super.dispose();
  }

  @override
  initState() {
    //Amplify.DataStore.clear();
    Amplify.DataStore.start();
    queryCategorias();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: new AppBar(
        title: new Text("Agregar evento:"),
        actions: <Widget>[
         new IconButton(icon: const Icon(Icons.save_rounded), onPressed: _trySubmitForm),
          new IconButton(icon: const Icon(Icons.logout_rounded), onPressed:  () => signOutCurrentUser())
        ],
      ),
      body: Container(
        color: Colors.blueGrey,
        alignment: Alignment.center,
        child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 35),
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                  key: _formKey,
                  child: ListView(
                    shrinkWrap: true,
                    //mainAxisSize: MainAxisSize.min,
                    children: [
                      /// Title
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Título'),
                        validator: (value) {
                          if (value == null || value
                              .trim()
                              .isEmpty) {
                            return 'Agrega el título del evento';
                          }
                          // Check if the entered email has the right format
                          //if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                          //  return 'Please enter a valid email address';
                          //}
                          // Return null if the entered email is valid
                          return null;
                        },
                        onChanged: (value) => _title = value,
                      ),

                      /// Description
                      TextFormField(
                        decoration:
                        const InputDecoration(labelText: 'Descripción'),
                        validator: (value) {
                          if (value == null || value
                              .trim()
                              .isEmpty) {
                            return 'Agrega una descripción del evento';
                          }
                          return null;
                        },
                        onChanged: (value) => _description = value,
                      ),
                      TextFormField(
                        decoration:
                        const InputDecoration(labelText: 'Frase de invitación'),
                        maxLength: 30,
                        validator: (value) {
                          if (value == null || value
                              .trim()
                              .isEmpty) {
                            return 'Agrega una frase de invitación al evento';
                          }
                          return null;
                        },
                        onChanged: (value) => _punchLine1 = value,
                      ),
                      DropdownButtonFormField(
                          decoration: InputDecoration(
                            labelText: "Categoria",
                            enabledBorder: OutlineInputBorder(
                              //borderSide: BorderSide(color: Colors.deepOrange, width: 0),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            border: OutlineInputBorder(
                              //borderSide: BorderSide(color: Colors.deepOrange, width: 0),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            filled: false,
                            fillColor: Colors.deepOrangeAccent,
                          ),
                        alignment: Alignment.center,
                        //dropdownColor: Colors.deepOrangeAccent,
                        items: menuItems,
                        value: _selectedCategory,
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value
                              .trim()
                              .isEmpty) {
                            return 'Selecciona una categoría';
                          }
                          return null;
                        }
                      ),
                      TextFormField(
                        controller: dateTimeController,
                        readOnly: true,
                        decoration:
                        const InputDecoration(labelText: 'Fecha y hora'),
                        validator: (value) {
                          if (value == null || value
                              .trim()
                              .isEmpty) {
                            return 'Agrega la fecha del evento';
                          }
                          return null;
                        },
                        onTap: () {
                          DatePicker.showDateTimePicker(context, showTitleActions: true,
                              onChanged: (date) {
                                print(DateFormat('E, d MMM yyyy hh:mm a').format(date));
                                _date =  DateFormat('E, d MMM yyyy hh:mm a').format(date);
                              },
                              onConfirm: (date) {
                                dateTimeController.text =  DateFormat('E, d MMM yyyy hh:mm a').format(date);
                              },
                              currentTime: dateTimeController.text.isNotEmpty ? new DateFormat('E, d MMM yyyy hh:mm a').parse(dateTimeController.text) : DateTime.now()
                          );
                        },
                        //onChanged: (value) => _date =  DateTime.parse(value),
                      ),
                      CSCPicker(
                        layout: Layout.vertical,
                        defaultCountry: CscCountry.Colombia,
                        dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                            border:
                            Border.all(color: Colors.grey.shade300, width: 1)),
                        countrySearchPlaceholder: "Pais",
                        stateSearchPlaceholder: "Departamento",
                        citySearchPlaceholder: "Municipio",
                        countryDropdownLabel: "Pais",
                        stateDropdownLabel: "Departamento",
                        cityDropdownLabel: "Municipio",
                        countryFilter: [CscCountry.Colombia,CscCountry.Panama],
                        selectedItemStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        dropdownHeadingStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                        dropdownItemStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        dropdownDialogRadius: 10.0,
                        searchBarRadius: 10.0,
                        onCountryChanged: (value){_country = value;},
                        onStateChanged:(value) {if(value != null){_departamento = value;}},
                        onCityChanged:(value) {if(value != null){_city = value;}},
                      ),
                      const SizedBox(height: 20),
                      _previewImages(),
                      Container(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                                onPressed: () {
                                  _getFromGallery();
                                },
                                child: Text("Agregar imagenes"),
                              )
                      ),
                    ],
                  )),
            ),
          ),
      ),
    );
  }


  Future<void> queryCategorias() async {
    Amplify.DataStore.start();
    List<DropdownMenuItem<String>> categoriasList = [];
    try {
     final List<Categoria> categorias = await Amplify.DataStore.query(Categoria.classType);
      //await Amplify.DataStore.save(nuevaCat);
      debugPrint("entra a queryCategorias");
      debugPrint("${categorias.length}");
      for (var elem in categorias) {
        categoriasList.add(DropdownMenuItem(value: elem.id, child: Text(elem.name)));
        //debugPrint(elem.name);
      }
    } catch (e) {
      print("Could not query DataStore: $e");
    }
    this.menuItems=categoriasList;
    setState(() { });
  }

  Widget _previewImages(){
    if(_imageFileList != null){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          for (final galleryImagePath in _imageFileList!)
            Container(
              margin: const EdgeInsets.only(left: 16, right: 16, bottom: 32),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child:  GestureDetector(
                  child:Hero(
                    tag: 'imageHero',
                    child: Image.file(
                      File(galleryImagePath.path),
                      width: 180,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
    }
    else{
      return const SizedBox(height: 20);
    }

  }
  _getFromGallery() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
      imageQuality: 100
    );
    if (pickedFile != null) {
      setState(() {
        _setImageFileListFromFile(pickedFile);
        print(_imageFileList);
      });
    }
  }
  void _setImageFileListFromFile(XFile? value) {
    if(_imageFileList == null) {
      _imageFileList = value == null ? null : <XFile>[value];
    }
    else{
      _imageFileList?.add(value!);
    }
  }

  Future<void> signOutCurrentUser() async {
    try {
      await Amplify.Auth.signOut();
    } on AuthException catch (e) {
      print(e.message);
    }
  }

}


