import Product from '../models/product.js';
import CustomError from '../errors/custom_error.js';

export const getProducts = async (req, res) => {
    const products = await Product.find({}).sort({ createdAt: -1});

    if (!products) {
        throw new CustomError('Failed to get products, try again later', 500);
    }

    res.json(products);
}
