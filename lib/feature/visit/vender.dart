import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tima_app/core/constants/button.dart';
import 'package:tima_app/core/constants/colorConst.dart';

class VendorPageView extends StatefulWidget {
  const VendorPageView({super.key});

  @override
  State<VendorPageView> createState() => _VendorPageViewState();
}

class _VendorPageViewState extends State<VendorPageView> {
  String? _selectedRedioBottonValue;
  String? _selectedProduct;

  // List of items in the dropdown
  final List<String> _dropdownProductServiceItems = [
    'Transport',
    'Electronic',
    'Developement',
    'Finance',
    'Vehicle'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Container(
                // margin: EdgeInsets.symmetric(horizontal: 20.w),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: seconderyColor.withOpacity(.6)),
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Vendor Name',
                      suffixIcon: Icon(Icons.refresh)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                // margin: EdgeInsets.symmetric(horizontal: 20.w),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: seconderyColor.withOpacity(.6)),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Person Name',
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                // margin: EdgeInsets.symmetric(horizontal: 20.w),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: seconderyColor.withOpacity(.6)),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Designation Name',
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                // margin: EdgeInsets.symmetric(horizontal: 20.w),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: seconderyColor.withOpacity(.6)),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Contact No',
                  ),
                ),
              ),
              SizedBox(
                height: 25.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 28.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      height: 42.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: seconderyColor.withOpacity(.5)),
                      child: Text("5.50 PM"),
                    ),
                    Container(
                        alignment: Alignment.center,
                        height: 45.h,
                        child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor: blueColor),
                            child: const Text(
                              'Select Start Time',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 17,
                                  color: Colors.white),
                            ))),
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),

              //pickimage feature
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 170.h,
                    width: 170.w,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: greyColor),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Image.network(
                      'https://png.pngtree.com/png-vector/20220825/ourmid/pngtree-creative-logo-design-vector-free-png-png-image_6123042.png',
                      fit: BoxFit.cover,
                      height: 150.h,
                      width: 160.w,
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                    width: 140.w,
                    child: ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            backgroundColor: blueColor),
                        label: const Text(
                          'Pick Image',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        icon: const Icon(
                          Icons.photo,
                          color: Colors.white,
                        )),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                // padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 50.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    // border: Border.all(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(15),
                    color: seconderyColor.withOpacity(.6)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    borderRadius: BorderRadius.circular(15),
                    value: _selectedProduct,
                    hint: const Text('Select Product/Service'),
                    items: _dropdownProductServiceItems.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedProduct = newValue;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              const Text(
                'Order Done',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ListTile(
                      title: const Text(
                        'Yes',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      leading: Radio<String>(
                        value: 'Yes',
                        groupValue: _selectedRedioBottonValue,
                        onChanged: (String? value) {
                          setState(() {
                            _selectedRedioBottonValue = value;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: const Text(
                        'No',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      leading: Radio<String>(
                        value: 'No',
                        groupValue: _selectedRedioBottonValue,
                        onChanged: (String? value) {
                          setState(() {
                            _selectedRedioBottonValue = value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                // margin: EdgeInsets.symmetric(horizontal: 20.w),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: seconderyColor.withOpacity(.6)),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Complaint',
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                // margin: EdgeInsets.symmetric(horizontal: 20.w),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 50.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: seconderyColor.withOpacity(.6)),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Remark',
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              const Text(
                'Next Visit',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 25.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 34.h,
                      width: 130.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1.5, color: greyColor)),
                      child: Text(
                        'Select a Date',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      )),
                  SizedBox(
                      height: 35.h,
                      width: 140.w,
                      child: CustomButton(
                        onPressed: () {},
                        text: 'Select Date',
                        radius: 10,
                        color: blueColor,
                        fontSize: 16,
                      ))
                ],
              ),
              SizedBox(
                height: 25.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 34.h,
                      width: 130.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1.5, color: greyColor)),
                      child: Text(
                        'Select a Time',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      )),
                  SizedBox(
                      height: 35.h,
                      width: 140.w,
                      child: CustomButton(
                        onPressed: () {},
                        text: 'Select Time',
                        radius: 10,
                        color: blueColor,
                        fontSize: 16,
                      ))
                ],
              ),
              SizedBox(
                height: 50.h,
              ),
              SizedBox(
                  height: 50.h,
                  width: double.infinity,
                  child: CustomButton(
                    onPressed: () {},
                    text: 'End Visit',
                    radius: 10,
                    color: blueColor,
                    fontSize: 17,
                  )),
              SizedBox(
                height: 100.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}
