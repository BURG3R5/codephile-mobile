import 'package:codephile/models/user_profile_details.dart';
import 'package:codephile/resources/colors.dart';
import 'package:codephile/screens/profile/accuracy_tile.dart';
import 'package:flutter/material.dart';

class AccuracyDisplay extends StatelessWidget {
  final UserProfileDetails? _platformDetails;
  const AccuracyDisplay(this._platformDetails, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
            child: Text(
              "Accuracy",
              style: TextStyle(
                  color: primaryBlackText,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Wrap(
            children: getAccuracyTileList(),
          )
        ],
      ),
    );
  }

  List<Widget> getAccuracyTileList() {
    List<AccuracyTile> accuracyTileList = <AccuracyTile>[];
    if (_platformDetails != null) {
      if (_platformDetails!.codechefProfile != null) {
        accuracyTileList.add(AccuracyTile(
            "codechef", _platformDetails!.codechefProfile!.accuracy));
      } else {
        accuracyTileList.add(const AccuracyTile("codechef", "-"));
      }

      if (_platformDetails!.codeforcesProfile != null) {
        accuracyTileList.add(AccuracyTile(
            "codeforces", _platformDetails!.codeforcesProfile!.accuracy));
      } else {
        accuracyTileList.add(const AccuracyTile("codeforces", "-"));
      }

      if (_platformDetails!.hackerrankProfile != null) {
        accuracyTileList.add(AccuracyTile(
            "hackerrank", _platformDetails!.hackerrankProfile!.accuracy));
      } else {
        accuracyTileList.add(const AccuracyTile("hackerrank", "-"));
      }

      if (_platformDetails!.spojProfile != null) {
        accuracyTileList
            .add(AccuracyTile("spoj", _platformDetails!.spojProfile!.accuracy));
      } else {
        accuracyTileList.add(const AccuracyTile("spoj", "-"));
      }
    } else {
      accuracyTileList.add(const AccuracyTile("codechef", "-"));
      accuracyTileList.add(const AccuracyTile("codeforces", "-"));
      accuracyTileList.add(const AccuracyTile("hackerrank", "-"));
      accuracyTileList.add(const AccuracyTile("spoj", "-"));
    }
    return accuracyTileList;
  }
}
