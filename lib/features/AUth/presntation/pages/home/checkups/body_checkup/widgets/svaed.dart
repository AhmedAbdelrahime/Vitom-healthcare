import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/home/checkups/body_checkup/widgets/checkupdetailspage.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/home/checkups/lung_checkup/lungchekupsdetals.dart';

class SavedCheckupsPage extends StatelessWidget {
  const SavedCheckupsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    CollectionReference lungCheckupsRef =
        FirebaseFirestore.instance.collection('lungcheckups');
    CollectionReference bodyCheckupsRef =
        FirebaseFirestore.instance.collection('bodycheckups');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Checkups'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildCheckupList(
                lungCheckupsRef, 'Lung Checkups', context, user?.uid,
                isLungCheckup: true),
          ),
          Expanded(
            child: _buildCheckupList(
                bodyCheckupsRef, 'Body Checkups', context, user?.uid),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckupList(CollectionReference checkupsRef, String checkupType,
      BuildContext context, String? userId,
      {bool isLungCheckup = false}) {
    return StreamBuilder<QuerySnapshot>(
      stream: checkupsRef.orderBy('date', descending: true).snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final docs = snapshot.data!.docs
              .where((doc) => doc['userId'] == userId)
              .toList();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  checkupType,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: docs.isEmpty
                    ? const Center(child: Text('No checkups saved.'))
                    : ListView.builder(
                        itemCount: docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot documentSnapshot = docs[index];
                          return ListTile(
                            title: Text(
                              '$checkupType - Checkup ${index + 1}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                                'Date: ${documentSnapshot['date'].toDate()}'),
                            onTap: () {
                              // Navigate to the checkup details page based on checkup type.
                              if (isLungCheckup) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        LungCheckupDetailsPage(
                                      documentSnapshot: documentSnapshot,
                                    ),
                                  ),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CheckupDetailsPage(
                                      documentSnapshot: documentSnapshot,
                                    ),
                                  ),
                                );
                              }
                            },
                          );
                        },
                      ),
              ),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
