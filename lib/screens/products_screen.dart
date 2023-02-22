import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/app_drawer.dart';
import '../components/product_item.dart';
import '../models/auth.dart';
import '../models/product_list.dart';
import '../utils/app_routes.dart';

class ProductsScreen extends StatelessWidget {
  ProductsScreen();

  Future<void> _refreshProducts(BuildContext context) {
    return Provider.of<ProductList>(
      context,
      listen: false,
    ).loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of(context, listen: false);
    final ProductList products = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar Produtos'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.productsForm);
            },
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: products.itemsCount,
            itemBuilder: (ctx, i) => Column(
              children: [
                if (products.items[i].userId == auth.userId)
                  ProductItem(products.items[i]),
                if (products.items[i].userId == auth.userId) const Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
