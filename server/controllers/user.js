import CustomError from '../errors/custom_error.js';
import User from '../models/user.js';
import Product from '../models/product.js';
import Order from '../models/order.js';

export const getUser = async (req, res) => {
    const { userId } = req.user;

    const user = await User.findById(userId).select('-password');

    if (!user) {
        throw new CustomError('User not found', 404);
    }

    const token = user.createToken();

    const userObject = user.toObject();
    res.status(200).json({ ...userObject, token });
}

export const manageCart = async (req, res) => {
    const { userId } = req.user;
    const { productId } = req.params;
    const { quantity } = req.body;

    if (!productId || !quantity.toString()) {
        throw new CustomError('Product ID and quantity required');
    }

    const user = await User.findById(userId).select('cart');

    if (!user) {
        throw new CustomError('User not found', 404);
    }

    const existingProduct = user.cart.findIndex(
        p => p.product.toString() === productId
    );

    if (existingProduct !== -1) {
        if (quantity === 0) {
            user.cart.splice(existingProduct, 1);
        } else {
            user.cart[existingProduct].quantity = quantity;
        }
    } else {
        if (quantity !== 0) {
            user.cart.push({ product: productId, quantity });
        }
    }

    await user.save();
    res.status(200).json(user);
}

export const getCartProducts = async (req, res) => {
    const { userId } = req.user;

    const user = await User.findById(userId).select('cart').populate('cart.product');

    if (!user) {
        throw new CustomError('Failed to get user', 500);
    }

    res.json(user);
}

export const placeOrder = async (req, res) => {
    const { userId: user } = req.user;
    const { products, totalPrice, address } = req.body;

    const order = await Order.create({user, products, totalPrice, address});

    if (!order) {
        throw new CustomError('Failed to place order', 500);
    }

    // subtract that much quantity from products
    for (const p of products) {
        const product = await Product.findById(p.product);
        if (product) {
            product.quantity -= p.quantity; 
            await product.save({ validateBeforeSave: true });
        }
    }

    await User.findByIdAndUpdate(user, { cart: [], address: address });

    res.status(201).json(order);
}

export const getAllOrders = async (req, res) => {
    const { user } = req.query;
    const queryObject = {};

    if (user) {
        queryObject.user = user;
    }

    const orders = await Order.find(queryObject).populate('products.product').sort({ createdAt: -1});
    res.json(orders);
}
