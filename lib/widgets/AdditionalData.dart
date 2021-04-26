import "package:flutter/material.dart";
import '../CentralState.dart';
import 'package:provider/provider.dart';
import '../StringExtension.dart';
import 'package:intl/intl.dart';

class AdditionalData extends StatelessWidget {
  AdditionalData(this.itemData, [this.prefix = ""]);
  final Map itemData;
  final String prefix;
  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];

    String formatIt(String field, String val) {
      if (field != "price" && field != "security") return val;
      var formatter = NumberFormat('#,##,000');
      return formatter.format(int.parse(val));
    }

    void doCheckingAndAdd(String name) {
      if (itemData[name] != null) {
        if (itemData[name] != "") {
          String fieldName = name;
          if (fieldName == "security") {
            fieldName = "security";
          }
          fieldName = fieldName.replaceAll(prefix, "");
          fieldName = fieldName.capitalize().trim();
          String value = itemData[name].toString();
          value = value.capitalize();
          widgets.add(Wrap(
            direction: Axis.horizontal,
            children: [
              Text("$fieldName: "),
              Text(formatIt(name, value),
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            ],
          ));
          widgets.add(SizedBox(
            height: 10,
          ));
        }
      }
    }

    // doCheckingAndAdd("type");
    doCheckingAndAdd(prefix + "stock");
    doCheckingAndAdd(prefix + "security");
    doCheckingAndAdd(prefix + "price");

    doCheckingAndAdd(prefix + "period");
    return Wrap(
        direction: Axis.horizontal,
        runSpacing: 10,
        spacing: 10,
        children: widgets);
  }
}
