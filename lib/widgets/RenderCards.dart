import "package:flutter/material.dart";
import "./DonationCard.dart";
import "../CentralState.dart";
import 'package:provider/provider.dart';
import "./Spinner.dart";

class RenderCards extends StatefulWidget {
  RenderCards(this.type);
  final String type;

  @override
  _RenderCardsState createState() => _RenderCardsState();
}

class _RenderCardsState extends State<RenderCards> {
  @override
  void initState() {
    super.initState();
    var state = Provider.of<CentralState>(context, listen: false);
    state.clearData("donations");

    Map<String, dynamic> body = {"basis": "donater"};
    if (widget.type == "feeds") {
      body = {"basis": "city", "value": state.data["city"]};
    }

    state.load("donations", "/donations", body: body);
  }

  @override
  Widget build(BuildContext context) {
    final Map data = context.watch<CentralState>().data;
    if (data["loading-donations"] != null) {
      if (data["loading-donations"] != true) return Spinner();
    }

    final List list = data["donations"];

    return Column(
        children: list.map((item) {
      return DonationCard(item.image, item.title, item.tags,item.id);
    }).toList());
  }
}
