import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: SavingGoals()));
}

class SavingGoals extends StatefulWidget {
  const SavingGoals({super.key});

  @override
  State<SavingGoals> createState() => _SavingGoalsState();
}

class _SavingGoalsState extends State<SavingGoals> {
  TextEditingController targetController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  bool isMonthly = false;
  int? savingsTarget = 0;
  int? savingsAmount = 0;
  int daysNeeded = 0;
  String msg = '';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            Text('SAVEit', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.amber)),
            SizedBox(height: 5),
            Container(
              width: 350,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(148, 158, 158, 158),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 2), // diagonal shadow (bottom-right)
                  ),
                ],
              ), 
              margin: EdgeInsets.only(top: 0, bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 13), 
                  Row(
                    children: [
                      SizedBox(
                        width: 130,
                        child: Text('Savings target: ')
                      ),
                      Text('RM', style: TextStyle(fontSize: 13)),
                      SizedBox(width: 3),
                      SizedBox(width: 150, height: 25, child: TextField(
                        keyboardType: TextInputType.number,
                        controller: targetController,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(vertical: 5),
                          hint: Text('Input a number', textAlign: TextAlign.center),
                          )
                        ),
                      ),
                    ]
                  ),
                  SizedBox(height: 15),
                  Row (
                    children: [
                      SizedBox(
                        width: 130,
                        child: Text('Savings amount: ')
                      ),
                      Text('RM', style: TextStyle(fontSize: 13)),
                      SizedBox(width: 3),
                      SizedBox(width: 150, height: 25, child: TextField(
                        keyboardType: TextInputType.number,
                        controller: amountController,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(vertical: 5),
                          hint: Text('Input a number', textAlign: TextAlign.center),
                          )
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 130,
                        child: Text('Saving intervals: ')
                      ),
                      Text('Per'),
                      SizedBox(width: 5),
                      DropdownButton<String>(
                        value: isMonthly ? 'month' : 'week',
                        items: <String>['week', 'month'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: TextStyle(fontSize: 13)),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            isMonthly = newValue == 'month';
                          });
                        }
                      ),  
                    ],
                  ),
                ],
              )
            ),
            ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.amber), onPressed: () {
              savingsAmount = int.tryParse(amountController.text);
              savingsTarget = int.tryParse(targetController.text);
              if (savingsAmount == null || savingsTarget == null || savingsAmount! <= 0 || savingsTarget! <= 0) {
                msg = 'Invalid input.';
              } else {
                if (isMonthly) {
                  daysNeeded = (savingsTarget! / (savingsAmount! / 31)).ceil();
                } else {
                  daysNeeded = (savingsTarget! / (savingsAmount! / 7)).ceil();
                }
                msg = 'You will need $daysNeeded days to reach your savings target.';
              };
              setState(() {});
            }, child: Text('Calculate')),
            Text(msg, style: TextStyle(fontSize: 16))
          ],
        )
      ),
    );
  }
}
