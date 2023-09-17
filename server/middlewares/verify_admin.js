import User from '../models/user.js';
import CustomError from '../errors/custom_error.js';

const verifyAdmin = async (req, res, next) => {
    const { userId } = req.user;

    const user = await User.findById(userId);

    if (!user) {
        throw new CustomError('Failed to get user, try again later', 500);
    }

    if (user.type !== 'admin') {
        throw new CustomError('Only admins are allowed to make these request', 401);
    }

    next();
}

export default verifyAdmin;
