import mongoose from "mongoose";
import CartProductSchema from "./cart_product.js";

const OrderSchema = mongoose.Schema({
    user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User', 
        required: true
    },
    products: [CartProductSchema],
    totalPrice: {
        type: Number,
        required: true
    },
    address: {
        type: String,
        required: true
    },
    status: {
        type: Number,
        default: 0,
        validate: {
            validator: (value) => {
                return value >= 0 && value <= 3;
            },
            message: 'Status must be between 0 and 3'
        }
    }
}, {timestamps: true});

export default mongoose.model('Order', OrderSchema);
