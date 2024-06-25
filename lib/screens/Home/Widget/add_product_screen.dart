import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  double? _price;
  String? _description;
  String? _category;
  String? _imageBase64;
  String? _review;
  String? _seller;
  List<String>? _colors = [];
  double? _rate;
  int? _quantity;

  final picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final bytes = await File(pickedFile.path).readAsBytes();
      setState(() {
        _imageBase64 = base64Encode(bytes);
      });
    }
  }

  Future<void> _submitProduct() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final response = await http.post(
        Uri.parse('http://192.168.58.67:8000/product'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'name': _name,
          'price': _price,
          'description': _description,
          'category': _category,
          'image_base64': _imageBase64,
          'review': _review,
          'seller': _seller,
          'colors': _colors,
          'rate': _rate,
          'quantity': _quantity,
        }),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Product added successfully'),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to add product: ${response.body}'),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onSaved: (value) => _name = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  return null;
                },
                onSaved: (value) => _price = double.tryParse(value ?? ''),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                onSaved: (value) => _description = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Category'),
                onSaved: (value) => _category = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Review'),
                onSaved: (value) => _review = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Seller'),
                onSaved: (value) => _seller = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Colors (comma separated)'),
                onSaved: (value) {
                  if (value != null && value.isNotEmpty) {
                    _colors = value.split(',').map((color) => color.trim()).toList();
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Rate'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _rate = double.tryParse(value ?? ''),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _quantity = int.tryParse(value ?? ''),
              ),
              SizedBox(height: 16),
              _imageBase64 == null
                  ? Text('No image selected.')
                  : Image.memory(
                      base64Decode(_imageBase64!),
                      height: 200,
                    ),
              TextButton.icon(
                icon: Icon(Icons.image),
                label: Text('Pick Image'),
                onPressed: _pickImage,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitProduct,
                child: Text('Submit Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
