import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:eventos_deportivos/common/services/storage_service.dart';

import 'package:eventos_deportivos/models/Event.dart';
import 'package:eventos_deportivos/features/data/events_repository.dart';

final eventControllerProvider = Provider<EventController>((ref) {
  return EventController(ref);
});

class EventController {
  EventController(this.ref);
  final Ref ref;

  Future<List>uploadFile(File file) async {
    final fileKey = await ref.read(storageServiceProvider).uploadFile(file);
    if (fileKey != null) {
      final imageUrl =
        await ref.read(storageServiceProvider).getImageUrl(fileKey);
      return [fileKey,imageUrl];
      //final updatedEvent = event.copyWith(eventImageKey: fileKey, eventImageUrl: imageUrl);
      //await ref.read(eventsRepositoryProvider).update(updatedEvent);
      ref.read(storageServiceProvider).resetUploadProgress();
    }
    return ["",""];
  }

  ValueNotifier<double> uploadProgress() {
    return ref.read(storageServiceProvider).getUploadProgress();
  }

  Future<void> edit(Event updatedEvent) async {
    final eventsRepository = ref.read(eventsRepositoryProvider);
    await eventsRepository.update(updatedEvent);
  }

  Future<void> delete(Event deletedEvent) async {
    final eventsRepository = ref.read(eventsRepositoryProvider);
    await eventsRepository.delete(deletedEvent);
  }
}