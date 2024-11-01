import 'package:flutter/material.dart';

class BookTableScreen extends StatefulWidget {
  @override
  _BookTableScreenState createState() => _BookTableScreenState();
}

class _BookTableScreenState extends State<BookTableScreen> {
  int partySize = 1;
  String? tableShape;

  void _bookTable() {
    // Book the table and navigate to the next screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TableStatusScreen(
          partySize: partySize,
          tableShape: tableShape,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Book a Table')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<int>(
              value: partySize,
              onChanged: (int? value) {
                setState(() {
                  partySize = value!;
                });
              },
              items: List.generate(
                10,
                (index) => DropdownMenuItem<int>(
                  value: index + 1,
                  child: Text('Party Size: ${index + 1}'),
                ),
              ),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: tableShape,
              onChanged: (String? value) {
                setState(() {
                  tableShape = value!;
                });
              },
              items: [
                DropdownMenuItem<String>(
                  value: 'circle',
                  child: Text('Circle Table (5)'),
                ),
                DropdownMenuItem<String>(
                  value: 'square',
                  child: Text('Square Table (4)'),
                ),
                DropdownMenuItem<String>(
                  value: 'rectangular',
                  child: Text('Rectangular Table (6)'),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _bookTable,
              child: Text('Book Table'),
            ),
          ],
        ),
      ),
    );
  }
}

class TableStatusScreen extends StatefulWidget {
  final int partySize;
  final String? tableShape;

  TableStatusScreen({required this.partySize, required this.tableShape});

  @override
  _TableStatusScreenState createState() => _TableStatusScreenState();
}

class _TableStatusScreenState extends State<TableStatusScreen> {
  List<String> tables = List.generate(16, (index) => 'Free');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Table Status')),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemCount: 16,
        itemBuilder: (context, index) {
          String tableStatus = tables[index];
          return InkWell(
            onTap: () {
              if (tableStatus == 'Free' &&
                  (widget.tableShape == 'circle' && widget.partySize <= 5 ||
                      widget.tableShape == 'square' && widget.partySize <= 4 ||
                      widget.tableShape == 'rectangular' &&
                          widget.partySize <= 6)) {
                setState(() {
                  tables[index] = 'Booked';
                });
              }
            },
            child: Container(
              color: tableStatus == 'Free' ? Colors.green : Colors.red,
              child: Center(
                child: Text(
                  'Table ${index + 1}\n($tableStatus)',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
