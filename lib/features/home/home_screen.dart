import 'package:buy_right/features/home/widgets/discount_container.dart';
import 'package:buy_right/features/home/widgets/grid_product.dart';
import 'package:buy_right/features/home/home_services.dart';
import 'package:buy_right/features/home/widgets/categories_row.dart';
import 'package:buy_right/features/home/widgets/loading_item.dart';
import 'package:buy_right/features/home/widgets/top_row.dart';
import 'package:buy_right/features/product_details/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/products_provider.dart';
import '../../utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final ProductsProvider productsProvider;

  bool _isLoading = false;
  int _selectedCategory = 0;

  void _changeSelectedCategory(index) {
    setState(() {
      _selectedCategory = index;
    });
  }

  void getProducts() async {
    if (productsProvider.products.isNotEmpty) {
      return;
    }

    setState(() {
      _isLoading = true;
    });
    await HomeServices.getProducts(context, mounted);

    if (mounted) {
      setState(() {
      _isLoading = false;
    });
    }
  }

  @override
  void initState() {
    super.initState();
    productsProvider = Provider.of<ProductsProvider>(context, listen: false);
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<ProductsProvider>(
        builder: (context, provider, child) {
          final filteredProducts = _selectedCategory == 0
              ? provider.products
              : provider.products
                  .where((product) =>
                      product.category.toLowerCase() ==
                      categories[_selectedCategory].toLowerCase())
                  .toList();

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(20.0),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TopRow(),
                      const SizedBox(
                        height: 20.0,
                      ),
                      const DiscountContainer(),
                      const SizedBox(
                        height: 20.0,
                      ),
                      CategoriesRow(
                        categories: categories,
                        selectedCategory: _selectedCategory,
                        handleClick: (index) => _changeSelectedCategory(index),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        _selectedCategory == 0
                            ? 'All Products'
                            : categories[_selectedCategory],
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                sliver: filteredProducts.isEmpty && !_isLoading
                    ? const SliverToBoxAdapter(
                        child: SizedBox(
                          height: 150.0,
                          child: Center(
                            child: Text('No product'),
                          ),
                        ),
                      )
                    : SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200.0,
                          childAspectRatio: 0.75,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 10.0,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          childCount: _isLoading ? 6 : filteredProducts.length,
                          (context, index) => GestureDetector(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ProductDetailsScreen(
                                  product: filteredProducts[index],
                                ),
                              ),
                            ),
                            child: _isLoading
                                ? const LoadingItem()
                                : GridProduct(
                                    name: filteredProducts[index].name,
                                    price: filteredProducts[index].price,
                                    imagePath:
                                        filteredProducts[index].images[0],
                                  ),
                          ),
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
