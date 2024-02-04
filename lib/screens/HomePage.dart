import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project1/components/Approved.dart';
import 'package:project1/components/Denied.dart';
import 'package:project1/components/OnHold.dart';
import 'package:project1/controller/RequestController.dart';
import 'package:project1/widgets/SendRequestBtn.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final controller = Get.put(RequestController());

  final List<Widget> _tabs = [
    OnHold(),
    Approved(),
    Denied(),
  ];

  Future<void> refresh() async {
    await controller.getRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Хүсэлт',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 28),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_alt_outlined),
            onPressed: () {
              _showFilterModal(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _tabs[_currentIndex],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.watch_later_outlined,
              color: Colors.orange,
            ),
            label: 'Хүлээгдэж буй',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline, color: Colors.orange),
            label: 'Зөвшөөрсөн',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.no_accounts_outlined, color: Colors.orange),
            label: 'Татгалзсан',
          ),
        ],
      ),
      floatingActionButton: SendRequestBtn(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _showFilterModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Шүүлтүүр',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 13,
                itemBuilder: (BuildContext context, int index) {
                  DateTime currentDate = DateTime.now();
                  DateTime previousMonth =
                      DateTime(currentDate.year, currentDate.month - index, 1);

                  String formattedDate =
                      DateFormat('yyyy-MM').format(previousMonth);

                  return ListTile(
                    title: Text(formattedDate),
                    onTap: () {
                      refresh();
                      print('Selected: $formattedDate');
                      controller.selectedMonth.value = formattedDate;
                      print(
                          'Updated selectedMonth: ${controller.selectedMonth.value}');
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
