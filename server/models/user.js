import mongoose from "mongoose";
import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';
import CartProductSchema from "./cart_product.js";

const UserSchema = mongoose.Schema({
    name: {
        type: String,
        required: true,
        min: 3,
        max: 50,
        trim: true
    },
    email: {
        type: String,
        required: true,
        unique: true,
        match: [
            /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/,
            'Please provide a valid email',
        ],
        trim: true
    },
    password: {
        type: String,
        required: true,
        min: 5
    },
    type: {
        type: String,
        default: 'customer',
        enum: ['customer', 'admin']
    },
    address: {
        type: String,
        default: ''
    },
    cart: [CartProductSchema]
},);

UserSchema.methods.comparePasswords = function (candidatePassword) {
    const result = bcrypt.compareSync(candidatePassword, this.password);
    return result;
}

UserSchema.methods.createToken = function () {
    return jwt.sign({ userId: this._id }, process.env.JWT_SECRET, { expiresIn: '30d' });
}

export default mongoose.model('User', UserSchema);
