import 'package:flutter/material.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/animated_app/homepage/home.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/animated_app/screens/profile/profile_body.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/animated_app/screens/profile/updatetest.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/home/chatbot/pages/chat_page.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/home/checkups/body_checkup/body_checkup_view.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/home/checkups/body_checkup/widgets/svaed.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/home/checkups/formheartrate/heartrateform.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/home/checkups/lung_checkup/lung_checkup_view.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/home/robotcontrol/controlpage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide.none, // Removes the border line
                ),
                filled: true,
                fillColor: Colors.grey[200], // Background color
              ),
              onChanged: (query) {
                setState(() {
                  _query = query;
                });
              },
            ),
            Expanded(
              child: _buildSearchResults(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    List<Widget> results = [];
    if (_query.isEmpty) {
      return Center(child: Text('Enter a search query'));
    } else {
      results = _searchPages(_query);
      if (results.isEmpty) {
        return Center(child: Text('No results found'));
      }
    }
    return ListView(
      children: results,
    );
  }

  List<Widget> _searchPages(String query) {
    List<Widget> results = [];

    // Check if the page title contains the search query
    // if (ProfileBody().toString().toLowerCase().contains(query.toLowerCase())) {
    //   results.add(_buildSearchResultItem('Profile Page', ProfileBody()));
    // // }
    // if (EditProfilePage()
    //     .toString()
    //     .toLowerCase()
    //     .contains(query.toLowerCase()))
    //      {
    //   results.add(
    //       _buildSearchResultItem(' Edite Profile Page', EditProfilePage()));
    // }
    if (ChatPage().toString().toLowerCase().contains(query.toLowerCase())) {
      results.add(_buildSearchResultItem(' ChatBot', const ChatPage()));
    }
    if (LungCheckupView()
        .toString()
        .toLowerCase()
        .contains(query.toLowerCase())) {
      results.add(_buildSearchResultItem(' Lung Checkups', LungCheckupView()));
    }
    if (BodyCheckupView()
        .toString()
        .toLowerCase()
        .contains(query.toLowerCase())) {
      results.add(
          _buildSearchResultItem('Body Checkups', const BodyCheckupView()));
    }
    if (ControlScreen()
        .toString()
        .toLowerCase()
        .contains(query.toLowerCase())) {
      results.add(_buildSearchResultItem('Control Robot', ControlScreen()));
    }
    if (SavedCheckupsPage()
        .toString()
        .toLowerCase()
        .contains(query.toLowerCase())) {
      results.add(_buildSearchResultItem(
          ' Saved  Checkups', const SavedCheckupsPage()));
    }
    if (HeartAttackRiskForm()
        .toString()
        .toLowerCase()
        .contains(query.toLowerCase())) {
      results.add(_buildSearchResultItem(
          'Heart Rate  Checkups', HeartAttackRiskForm()));
    }
    if (RiveAppHome().toString().toLowerCase().contains(query.toLowerCase())) {
      results.add(_buildSearchResultItem('Home Page', const RiveAppHome()));
    }

    return results;
  }

  Widget _buildSearchResultItem(String title, Widget page) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
    );
  }
}
