import express from 'express';
import { getUser, manageCart, getCartProducts, placeOrder, getAllOrders } from '../controllers/user.js';

const router = express.Router();

router.route('/get-user').get(getUser);
router.route('/get-cart-products').get(getCartProducts);
router.route('/manage-cart/:productId').patch(manageCart);
router.route('/place-order').post(placeOrder);
router.route('/get-all-orders').get(getAllOrders);

export default router;
