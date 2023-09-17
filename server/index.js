import express from 'express';
import 'express-async-errors';
import dotenv from 'dotenv';
import authRouter from './routes/auth.js';
import userRouter from './routes/user.js';
import adminRouter from './routes/admin.js';
import productsRouter from './routes/products.js';
import auth from './middlewares/authorization.js';
import notFound from './middlewares/not_found.js';
import errorHandler from './middlewares/error_handler.js';
import connectDb from './utils/connect_db.js';
import verifyAdmin from './middlewares/verify_admin.js';

dotenv.config();
const app = express();

app.use(express.json());

app.get('/', (req, res) => res.send('BuyRight Server'));

app.use('/api/auth', authRouter);
app.use('/api/user', auth, userRouter);
app.use('/api/products', auth, productsRouter);
app.use('/api/admin', auth, verifyAdmin, adminRouter);

app.use(notFound);
app.use(errorHandler);

const PORT = process.env.PORT || 8000;

const startServer = async () => {
    await connectDb(process.env.MONGO_URL);
    app.listen(PORT, () => console.log(`server listening on port ${PORT}`));
}

startServer();
