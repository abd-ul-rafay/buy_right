import bcrypt from 'bcryptjs';
import User from '../models/user.js';
import CustomError from '../errors/custom_error.js';

export const login = async (req, res) => {
    const { email, password } = req.body;

    if (!email || !password) {
        throw new CustomError('Please provide email and password', 400);
    }

    const user = await User.findOne({ email });

    if (!user) {
        throw new CustomError('User with this email not found', 404);
    }

    const isValidPassword = await user.comparePasswords(password);

    if (!isValidPassword) {
        throw new CustomError('Invalid credentials', 401);
    }

    const token = user.createToken();

    const createdUser = user.toObject();
    delete createdUser.password;

    res.status(200).json({ ...createdUser, token });
}

export const register = async (req, res) => {
    const { name, email, password } = req.body;

    if (!name || !email || !password) {
        throw new CustomError('Please provide name, email and password', 400);
    }

    if (name.length < 3) {
        throw new CustomError('Name must be at least 3 characters', 400);
    }

    if (password.length < 5) {
        throw new CustomError('Password must be at least 5 characters', 400);
    }

    const salt = bcrypt.genSaltSync(10);
    const hashedPassword = bcrypt.hashSync(password, salt);

    const user = await User.create({ name, email, password: hashedPassword });
    const token = user.createToken();

    const createdUser = user.toObject();
    delete createdUser.password;

    res.status(201).json({ ...createdUser, token });
}
