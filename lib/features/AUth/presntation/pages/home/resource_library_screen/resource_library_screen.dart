import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ResourceLibraryScreen extends StatefulWidget {
  @override
  _ResourceLibraryScreenState createState() => _ResourceLibraryScreenState();
}

class _ResourceLibraryScreenState extends State<ResourceLibraryScreen> {
  final List<Resource> resources = [
    Resource(
        'Understanding Heart Disease',
        'https://www.healthline.com/health/heart-disease',
        ResourceType.Article,
        'Heart'),
    Resource('Lung Health Tips', 'https://www.youtube.com/watch?v=IwsljkMSVok',
        ResourceType.Video, 'Lung'),
    Resource(
        'Cardiovascular Health',
        'https://chronicdisease.org/page/cardiovascularhealth/#:~:text=Cardiovascular%20health%20refers%20to%20the,arrhythmias%2C%20and%20heart%20valve%20problems.',
        ResourceType.Article,
        'Heart'),
    Resource(
        'Breathing Exercises',
        'https://www.youtube.com/watch?v=7Ep5mKuRmAA',
        ResourceType.Video,
        'Lung'),
    Resource(
        'Healthy Eating',
        'https://www.helpguide.org/articles/healthy-eating/healthy-eating.htm',
        ResourceType.Article,
        'General'),
    Resource(
        'Exercise for Heart Health',
        'https://www.youtube.com/watch?v=wZEUomaZOS8',
        ResourceType.Video,
        'Heart'),
    Resource(
        'Understanding Blood Pressure',
        'https://www.heart.org/en/health-topics/high-blood-pressure/understanding-blood-pressure-readings',
        ResourceType.Article,
        'Heart'),
    Resource(
        'Meditation for Stress Relief',
        'https://www.youtube.com/watch?v=MIr3RsUWrdo',
        ResourceType.Video,
        'General'),
    Resource(
        'Diabetes Management',
        'https://www.mayoclinic.org/diseases-conditions/diabetes/in-depth/diabetes-management/art-20047963',
        ResourceType.Article,
        'General'),
    Resource(
        'Yoga for Beginners',
        'https://www.youtube.com/playlist?list=PLui6Eyny-UzzWwB4h9y7jAzLbeuCUczAl',
        ResourceType.Video,
        'General'),
  ];

  String searchQuery = '';
  String selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    final filteredResources = resources.where((resource) {
      final matchesQuery =
          resource.title.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesCategory =
          selectedCategory == 'All' || resource.category == selectedCategory;
      return matchesQuery && matchesCategory;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Resource Library'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: selectedCategory,
              onChanged: (newValue) {
                setState(() {
                  selectedCategory = newValue!;
                });
              },
              items: <String>['All', 'Heart', 'Lung', 'General']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredResources.length,
              itemBuilder: (context, index) {
                final resource = filteredResources[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    title: Text(
                      resource.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    leading: Icon(
                      resource.type == ResourceType.Article
                          ? Icons.article
                          : Icons.video_library,
                      color: resource.type == ResourceType.Article
                          ? Colors.blue
                          : Colors.red,
                      size: 40,
                    ),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {
                      _launchURL(resource.link, context);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _launchURL(String url, BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Navigator.pop(
          context); // Close the loading indicator if the URL can't be launched
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
    Navigator.pop(
        context); // Close the loading indicator once the URL is launched
  }
}

class Resource {
  final String title;
  final String link;
  final ResourceType type;
  final String category;

  Resource(this.title, this.link, this.type, this.category);
}

enum ResourceType {
  Article,
  Video,
}
