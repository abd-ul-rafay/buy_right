import mongoose from "mongoose";

const ProductSchema = mongoose.Schema({
    name: {
        type: String,
        required: true,
        trim: true,
        min: 2,
        max: 100
    },
    description: {
        type: String,
        required: true,
        trim: true,
        min: 2
    },
    images: [{
        type: String,
        required: true
    }],
    price: {
        type: Number,
        required: true,
    },
    quantity: {
        type: Number,
        required: true,
        validate: {
            validator: (value) => {
                return value >= 0;
            },
            message: 'Quantity can not be negative'
        }
    },
    category: {
        type: String,
        required: true
    }
}, { timestamps: true });

export default mongoose.model('Product', ProductSchema);
