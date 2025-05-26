import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/service_item.dart';

// Provider for the selected navigation tab
final selectedTabProvider = StateProvider<int>((ref) => 0);

// Firebase stream provider for services collection
final servicesStreamProvider = StreamProvider<List<ServiceItem>>((ref) {
  return FirebaseFirestore.instance.collection('services').snapshots().map(
    (snapshot) {
      return snapshot.docs.map((doc) {
        return ServiceItem.fromMap(doc.data());
      }).toList();
    },
  );
});