import 'package:flutter/material.dart';
import 'package:Henfam/widgets/largeTextSection.dart';

class BigFilter extends StatefulWidget {
  @override
  _BigFilterState createState() => _BigFilterState();
}

class _BigFilterState extends State<BigFilter> {
  RangeValues _values = RangeValues(1.0, 3.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text('Filter Results'), backgroundColor: Colors.amber),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _titleContainer("Choose restaurants"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    child: Wrap(
                  spacing: 5.0,
                  runSpacing: 3.0,
                  children: <Widget>[
                    FilterChipWidget(chipName: 'Oishii Bowl'),
                    FilterChipWidget(chipName: 'Kung Fu Tea'),
                    FilterChipWidget(chipName: 'Poke Lava'),
                    FilterChipWidget(chipName: 'Starbucks'),
                    FilterChipWidget(chipName: "Jack's Grill"),
                    FilterChipWidget(chipName: 'Insomnia Cookies'),
                  ],
                )),
              ),
            ),
            Divider(
              color: Colors.blueGrey,
              height: 10.0,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _titleContainer('Choose delivery locations'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Wrap(
                    spacing: 5.0,
                    runSpacing: 5.0,
                    children: <Widget>[
                      FilterChipWidget(chipName: 'North Campus'),
                      FilterChipWidget(chipName: 'West Campus'),
                      FilterChipWidget(chipName: 'Engineering Quad'),
                      FilterChipWidget(chipName: 'Ho Plaza'),
                      FilterChipWidget(chipName: 'PSB'),
                      FilterChipWidget(chipName: 'Collegetown eHub'),
                      FilterChipWidget(chipName: 'Olin Library'),
                      FilterChipWidget(chipName: 'Mann Library'),
                      FilterChipWidget(chipName: 'FILTER WITH MAP'),
                    ],
                  ),
                ),
              ),
            ),
            Divider(
              color: Colors.blueGrey,
              height: 10.0,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _titleContainer('Choose max item quantity'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Wrap(
                    spacing: 5.0,
                    runSpacing: 5.0,
                    children: <Widget>[
                      FilterChipWidget(
                          chipName: '01'), //change these to action chips later
                      FilterChipWidget(chipName: '02'),
                      FilterChipWidget(chipName: '03'),
                      FilterChipWidget(chipName: '04'),
                      FilterChipWidget(chipName: '05'),
                      FilterChipWidget(chipName: '06'),
                      FilterChipWidget(chipName: '07'),
                    ],
                  ),
                ),
              ),
            ),
            Divider(
              color: Colors.blueGrey,
              height: 10.0,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _titleContainer('Choose delivery window'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: RangeSlider(
                      values: _values,
                      onChanged: (RangeValues newRange) {
                        setState(() {
                          _values = newRange;
                        });
                      },
                      min: 0.0,
                      max: 12.0,
                      activeColor: Colors.amberAccent,
                      inactiveColor: Color(0xffededed),
                      divisions: 12,
                      labels:
                          RangeLabels('${_values.start}', '${_values.end}'))),
            ),
            Divider(
              color: Colors.blueGrey,
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}

Widget _titleContainer(String myTitle) {
  return Text(
    myTitle,
    style: TextStyle(
        color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
  );
}

class FilterChipWidget extends StatefulWidget {
  final String chipName;

  FilterChipWidget({Key key, this.chipName}) : super(key: key);

  @override
  _FilterChipWidgetState createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
  var _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.chipName),
      // labelStyle: TextStyle(
      //     color: Color(0xff6200ee),
      //     fontSize: 16.0,
      //     fontWeight: FontWeight.bold),
      selected: _isSelected,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      backgroundColor: Color(0xffededed),
      onSelected: (isSelected) {
        setState(() {
          _isSelected = isSelected;
        });
      },
      selectedColor: Colors.amberAccent, //Color(0xffeadffd),
    );
  }
}
