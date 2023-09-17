import CustomError from '../errors/custom_error.js';
import Product from '../models/product.js';
import Order from '../models/order.js';

export const addProduct = async (req, res) => {
    const { name, description, images, price, quantity, category } = req.body;

    if (!name || !description || !images || !price || !quantity || !category) {
        throw new CustomError('All product details are required', 400);
    }

    const product = await Product.create({ name, description, images, price, quantity, category });

    if (!product) {
        throw new CustomError('Failed to add product, try again later', 500);
    }

    res.status(201).json(product);
}

export const deleteProduct = async (req, res) => {
    const { productId } = req.body;

    if (!productId) {
        throw new CustomError('Product id required', 400);
    }

    const product = await Product.findByIdAndDelete(productId);

    if (!product) {
        throw new CustomError('Something went wrong', 500);
    }

    res.status(200).json(product);
}

export const changeOrderStatus = async (req, res) => {
    const { orderId, status } = req.body;

    if (!orderId || !status) {
        throw new CustomError('Order ID and status are required', 400);
    }

    const order = await Order.findByIdAndUpdate(
        orderId,
        { status: status },
        { new: true, runValidators: true }
    );

    if (!order) {
        throw new CustomError('Failed to get order, try again later', 500);
    }

    res.status(200).json(order);
}

export const analytics = async (req, res) => {
    const orders = await Order.find()
        .populate('products.product').sort({ createdAt: -1 });;

    if (!orders) {
        throw new CustomError('Something went wrong', 500);
    }

    const categories = {
        All: 0,
        Electronics: 0,
        Fashion: 0,
        Books: 0,
        Health: 0,
        Furniture: 0,
        Entertainment: 0,
        Others: 0,
    };

    orders.map(order => {
        order.products.map(cartProduct => {
            categories['All'] += cartProduct.quantity * cartProduct.product.price;
            if (cartProduct.product.category !== 'All') {
                categories[cartProduct.product.category] += cartProduct.quantity *  cartProduct.product.price;
            } else {
                categories['Others'] += cartProduct.quantity *  cartProduct.product.price;
            }
        })

    });

    res.status(200).json(categories);
}
