import 'package:flutter/material.dart';

void main() {
  runApp(CosmeticApp());
}

class CosmeticApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cosmetic Shopping',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductListScreen(),
    );
  }
}

class ProductListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cosmetic Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: cosmeticProducts.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(cosmeticProducts[index]),
                ),
              );
            },
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    color: Colors.grey[200],
                    height: 150,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      cosmeticProducts[index].name,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Price: ₹${cosmeticProducts[index].price}',
                          style: TextStyle(fontSize: 14),
                        ),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Add to cart logic goes here
                                // You can implement this based on your requirement
                                addToCart(cosmeticProducts[index]);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Added to cart: ${cosmeticProducts[index].name}'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              },
                              child: Text('Add to Cart'),
                            ),
                            SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () {
                                // Buy now logic goes here
                                // You can implement this based on your requirement
                                buyNow(context, cosmeticProducts[index]);
                              },
                              child: Text('Buy Now'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ProductDetailScreen extends StatelessWidget {
  final CosmeticProduct product;

  ProductDetailScreen(this.product);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: Colors.grey[200],
              height: 200,
            ),
            SizedBox(height: 16),
            Text(
              'Price: ₹${product.price}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'Description:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              product.description,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class CosmeticProduct {
  final String name;
  final double price;
  final String description;

  CosmeticProduct({
    required this.name,
    required this.price,
    required this.description,
  });
}

// Sample data
List<CosmeticProduct> cosmeticProducts = [
  CosmeticProduct(
    name: 'Lipstick',
    price: 800.0, // Price in INR
    description: 'Long-lasting matte lipstick in various shades.',
  ),
  CosmeticProduct(
    name: 'Eyeshadow Palette',
    price: 2000.0, // Price in INR
    description: 'Palette with 12 vibrant eyeshadow colors.',
  ),
  CosmeticProduct(
    name: 'Foundation',
    price: 1200.0, // Price in INR
    description: 'Full-coverage liquid foundation suitable for all skin types.',
  ),
  CosmeticProduct(
    name: 'Mascara',
    price: 600.0, // Price in INR
    description: 'Lengthening and volumizing mascara for dramatic lashes.',
  ),
];

// Cart
List<CosmeticProduct> cartItems = [];

void addToCart(CosmeticProduct product) {
  cartItems.add(product);
}

void buyNow(BuildContext context, CosmeticProduct product) {
  // Navigate to the payment page
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PaymentPage(product),
    ),
  );
}

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(cartItems[index].name),
            subtitle: Text('₹${cartItems[index].price}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Buy now logic from cart page
          // You can implement this based on your requirement
          buyNowFromCart(context);
        },
        child: Icon(Icons.payment),
      ),
    );
  }

  void buyNowFromCart(BuildContext context) {
    // If cart is not empty, navigate to the payment page
    if (cartItems.isNotEmpty) {
      // Navigate to the payment page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentPage(null),
        ),
      );
    } else {
      // Show a message that the cart is empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Your cart is empty.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}

class PaymentPage extends StatelessWidget {
  final CosmeticProduct? product;

  PaymentPage(this.product);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Total Amount:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              calculateTotalAmount(),
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 32),
            Text(
              'Enter Payment Details:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(labelText: 'Card Number'),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Expiry Date'),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'CVV'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Payment processing logic goes here
                // You can implement this based on your requirement
                processPayment(context);
              },
              child: Text('Complete Payment'),
            ),
          ],
        ),
      ),
    );
  }

  String calculateTotalAmount() {
    double total = 0.0;
    if (product != null) {
      total += product!.price;
    } else {
      for (var item in cartItems) {
        total += item.price;
      }
    }
    return '₹$total';
  }

  void processPayment(BuildContext context) {
    // Payment processing logic goes here
    // You can implement this based on your requirement
    // For example, show a success message and navigate to the home screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Payment Successful.'),
        duration: Duration(seconds: 2),
      ),
    );
    // Clear the cart after successful payment
    cartItems.clear();
    // Navigate back to the home screen
    Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
  }
}
