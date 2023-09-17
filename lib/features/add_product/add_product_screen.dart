import 'dart:io';
import 'package:buy_right/common/custom_text_field.dart';
import 'package:buy_right/models/product.dart';
import 'package:buy_right/utils/functions.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import '../../common/custom_button.dart';
import '../../utils/constants.dart';
import 'add_product_services.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameTextController = TextEditingController();
  final _descTextController = TextEditingController();
  final _priceTextController = TextEditingController();
  final _quantityTextController = TextEditingController();

  List<File> _images = [];
  String _dropDownValue = categories.first;

  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _nameTextController.dispose();
    _descTextController.dispose();
    _priceTextController.dispose();
    _quantityTextController.dispose();
  }

  void _handleButtonClick() {
    if (_formKey.currentState!.validate()) {
      if (_images.isEmpty) {
        return showSnackBar(context, 'Add at least one image');
      }

      FocusScope.of(context).unfocus();
      setState(() {
        _isLoading = true;
      });

      final product = Product(
        id: '',
        name: _nameTextController.text,
        description: _descTextController.text,
        images: [],
        price: double.parse(_priceTextController.text),
        quantity: int.parse(_quantityTextController.text),
        category: _dropDownValue,
      );

      AddProductServices.addProduct(
        context,
        product,
        _images,
        (name) => {
          showSnackBar(context, 'Product $name added successfully'),
          Navigator.pop(context)
        },
        mounted,
      );
    }
  }

  void handleAddImages() async {
    final images = await pickImages();
    setState(() {
      _images = images;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      controller: _nameTextController,
                      label: 'Name',
                      iconData: Icons.info,
                      textInputType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    CustomTextField(
                      controller: _descTextController,
                      label: 'Description',
                      iconData: Icons.description,
                      textInputType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    InkWell(
                      onTap: handleAddImages,
                      child: DottedBorder(
                        color: Colors.grey.shade500,
                        strokeWidth: 1,
                        dashPattern: const [4, 4],
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(12.0),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 16.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.image_outlined,
                                color: Colors.grey.shade600,
                              ),
                              const SizedBox(
                                width: 12.0,
                              ),
                              Text(
                                _images.isEmpty
                                    ? 'Add Images'
                                    : '${_images.length} images added',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 16.0,
                                ),
                              ),
                              const SizedBox(
                                width: 12.0,
                              ),
                              Visibility(
                                visible: _images.isNotEmpty,
                                child: InkWell(
                                  onTap: () => setState(
                                    () {
                                      _images = [];
                                    },
                                  ),
                                  child: Icon(
                                    Icons.cancel,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    CustomTextField(
                      controller: _priceTextController,
                      label: 'Price',
                      iconData: Icons.attach_money,
                      textInputType: TextInputType.number,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    CustomTextField(
                      controller: _quantityTextController,
                      label: 'Quantity',
                      iconData: Icons.production_quantity_limits,
                      textInputType: TextInputType.number,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    DropdownButton(
                      value: _dropDownValue,
                      items: categories
                          .map(
                            (category) => DropdownMenuItem(
                              value: category,
                              child: SizedBox(
                                width: 200.0,
                                child: Text(category),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => setState(
                        () {
                          _dropDownValue = value ?? categories.first;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    CustomButton(
                      onPressed: _handleButtonClick,
                      text: 'Add Product',
                      isLoading: _isLoading,
                      loadingText: 'Adding Product...',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
