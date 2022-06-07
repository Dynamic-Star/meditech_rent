ort 'package:flutter/material.dart';
import 'package:meditech_rent/Screens/add_address.dart';
import 'package:meditech_rent/Screens/payment_method.dart';
import 'package:meditech_rent/centralized.dart';

class editRantDetail extends StatefulWidget {
  String tempStartDate;
  String tempEndDate;

  TextEditingController? startDate;
  TextEditingController? endDate;
  editRantDetail(this.tempEndDate, this.tempStartDate);

  @override
  State<editRantDetail> createState() => _editRantDetailState();
}

class _editRantDetailState extends State<editRantDetail> {
  @override
  void initState() {
    widget.startDate = TextEditingController(text: widget.tempStartDate);
    widget.endDate = TextEditingController(text: widget.tempEndDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: const BoldFont("edit date", 20, darkblue),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: darkblue,
            size: 30,
          ),
        ),
        elevation: 0.0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[Colors.white, background],
            end: Alignment.bottomCenter,
            begin: Alignment.topCenter,
          ),