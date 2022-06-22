import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
class DatePickers  extends StatefulWidget {
  @override
  State<DatePickers> createState() => _DatePickersState();
}

class _DatePickersState extends State<DatePickers> {
  @override
  Widget build(BuildContext context) {

    final deviceSize = MediaQuery.of(context).size;
    final dateTextStyle = TextStyle(
        fontFamily: 'Aller',
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary.withOpacity(.6),
        fontSize: deviceSize.width * .039);
    final dateButtonStyle = ButtonStyle(
      elevation: MaterialStateProperty.all(3),
      backgroundColor:
      MaterialStateProperty.all(Theme.of(context).colorScheme.secondary),
    );
    final labelTextStyle = TextStyle(
        fontSize: deviceSize.width * .04,
        fontFamily: 'Aller');
    DateTime startDate = DateTime.now();
    DateTime endDate = DateTime.now().add(const Duration(days: 1));
    return Container(
      height: deviceSize.height*.19,
      width: deviceSize.width * .98,
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    top: deviceSize.height * .019,
                    right: deviceSize.width * .25),
                child: Text(
                  'Start date',
                  style: dateTextStyle,
                ),
              ),
              Container(
                width: deviceSize.width * .433,
                child: TextFormField(
                  style: labelTextStyle,
                  enabled: false,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.calendar_today_outlined,
                      size: deviceSize.width * .06,
                    ),
                    label: Text(
                        '${formatDate(startDate, [
                          yyyy,
                          '-',
                          mm,
                          '-',
                          dd
                        ])}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: deviceSize.width * .04),
                        textAlign: TextAlign.left),
                  ),
                ),
              ),
              ElevatedButton(
                style: dateButtonStyle,
                child: Text(
                  'Tap to change',
                  style: TextStyle(
                      color:
                      Theme.of(context).colorScheme.primary,
                      fontSize: deviceSize.width * .039),
                ),
                onPressed: () {
                  showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2022, 12, 31))
                      .then((value) {
                    if (value != null) {
                      setState(() {
                        startDate = value;
                        endDate = startDate
                            .add(const Duration(days: 1));
                      });
                    }
                  });
                },
              ),
            ],
          ),
          SizedBox(
            width: deviceSize.width * .0027,
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    top: deviceSize.height * .019,
                    right: deviceSize.width * .2),
                child: Text(
                  'Leave date',
                  style: dateTextStyle,
                ),
              ),
              Container(
                width: deviceSize.width * .433,
                child: TextFormField(
                  enabled: false,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.calendar_today_outlined,
                      size: deviceSize.width * .06,
                    ),
                    label: Text(
                        '${formatDate(endDate, [
                          yyyy,
                          '-',
                          mm,
                          '-',
                          dd
                        ])}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: deviceSize.width * .04),
                        textAlign: TextAlign.left),
                  ),
                ),
              ),
              ElevatedButton(
                style: dateButtonStyle,
                child: Text(
                  'Tap to change',
                  style: TextStyle(
                      color:
                      Theme.of(context).colorScheme.primary,
                      fontSize: deviceSize.width * .039),
                ),
                onPressed: () {
                  showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2022, 12, 31))
                      .then((value) {
                    if (value != null) {
                      setState(() {
                        endDate = value;
                      });
                    }
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
