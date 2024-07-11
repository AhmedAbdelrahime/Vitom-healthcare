import 'package:flutter/material.dart';
import 'package:complex_ui_rive_animation/core/Widgets/profilemenuwidget.dart';
import 'package:complex_ui_rive_animation/core/constans.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class BillingDetailsPage extends StatelessWidget {
  const BillingDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Billing Details  this  '),
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(LineAwesomeIcons.angle_left)),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(
                'Your Billing Details',
                style: Theme.of(context).textTheme.titleLarge,
                selectionColor: KMainColor,
              ),
              const SizedBox(height: 20),
              ProfileMenuWidget(
                  title: "Card Number",
                  icon: LineAwesomeIcons.credit_card,
                  onPress: () {}),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Card Number',
                  hintText: 'Enter your card number',
                  border: OutlineInputBorder(),
                ),
              ),
              ProfileMenuWidget(
                  title: "Expiry Date",
                  icon: LineAwesomeIcons.calendar,
                  onPress: () {}),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Expiration Date',
                  hintText: 'Enter your expiration date',
                  border: OutlineInputBorder(),
                ),
              ),
              ProfileMenuWidget(
                  title: "CVV", icon: LineAwesomeIcons.lock, onPress: () {}),
              TextField(
                decoration: InputDecoration(
                  labelText: 'CVV',
                  hintText: 'Enter your CVV',
                  border: OutlineInputBorder(),
                ),
              ),
              ProfileMenuWidget(
                  title: "Billing Address",
                  icon: LineAwesomeIcons.map_marker,
                  onPress: () {}),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Billing Address',
                  hintText: 'Enter your billing address',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: KMainColor,
                      elevation: 0,
                      side: BorderSide.none,
                      shape: const StadiumBorder()),
                  child: const Text('Save Changes',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                  child: Text(
                'This page is for testing and the methods do not work',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
