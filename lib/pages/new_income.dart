import 'package:cipherschools_flutter_assignment/providers/transaction_provider.dart';
import 'package:cipherschools_flutter_assignment/utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../models/transaction.dart';
import '../widgets/my_textfield.dart';

class NewIncomePage extends StatefulWidget {
  const NewIncomePage({super.key});

  @override
  State<NewIncomePage> createState() => _NewIncomePageState();
}

class _NewIncomePageState extends State<NewIncomePage> {
  TextEditingController valueController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  String? selectedCategory;

  final List<String> categories = [
    'Category',
    'Salary',
    'Provisional Fund',
    'Rent',
    'Sales',
    'Other',
  ];
  bool isLoading = false;
  final List<String> wallet = ['Wallet', 'Bank'];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: ColorConstants.primary,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: const Text(
          "Income",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: height,
              width: width,
              decoration: BoxDecoration(color: ColorConstants.primary),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      const Text(
                        "How much?",
                        style:
                            TextStyle(color: Color.fromRGBO(252, 252, 252, 1)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            '₹',
                            style: TextStyle(
                              fontSize: 64,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: TextField(
                              controller: valueController,
                              cursorColor: Colors.white,
                              style: const TextStyle(
                                fontSize: 64,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(0),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                hintText: '0',
                                hintStyle: TextStyle(
                                  fontSize: 64,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ]),
              ),
            ),
            Positioned(
                top: height * 0.35,
                child: Container(
                  height: height * 0.6,
                  width: width,
                  padding: const EdgeInsets.all(25),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: double.maxFinite,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                                color: Colors.grey.shade300, width: 1)),
                        child: DropdownButton<String>(
                          hint: const Text("Category"),
                          value: selectedCategory,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedCategory = newValue;
                            });
                          },
                          items: categories
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      MyTextField(
                        myController: descriptionController,
                        hintText: 'Description',
                        isPassword: false,
                      ),
                      Spacer(),
                      Container(
                        width: double.maxFinite,
                        height: 56,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16)),
                        child: isLoading
                            ? Center(
                                child: SpinKitWave(
                                  color: ColorConstants.primary,
                                  size: 20,
                                ),
                              )
                            : ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  Transaction newTransaction = Transaction(
                                      category: selectedCategory.toString(),
                                      description: descriptionController.text,
                                      amount:
                                          double.parse(valueController.text),
                                      date: DateTime.now(),
                                      isCredit: true,
                                      key: UniqueKey().toString());
                                  Provider.of<TransactionProvider>(context,
                                          listen: false)
                                      .addTransaction(newTransaction);
                                  setState(() {
                                    isLoading = false;
                                  });
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorConstants.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                ),
                                child: const Text(
                                  'Continue',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                      ),
                      SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
