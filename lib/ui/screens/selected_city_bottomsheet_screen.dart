import 'package:flutter/material.dart';

class SelectedCityBottomsheetScreen extends StatefulWidget {
  const SelectedCityBottomsheetScreen({super.key});

  static const routeName = '/bottom-sheet';

  @override
  State<SelectedCityBottomsheetScreen> createState() =>
      _SelectedCityBottomsheetScreenState();
}

class _SelectedCityBottomsheetScreenState
    extends State<SelectedCityBottomsheetScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Bottom Sheet Content',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}
