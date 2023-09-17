import express from 'express';
import { addProduct, analytics, changeOrderStatus, deleteProduct } from '../controllers/admin.js';

const router = express.Router();

router.route('/add-product').post(addProduct);
router.route('/delete-product').delete(deleteProduct);
router.route('/change-order-status').patch(changeOrderStatus);
router.route('/analytics').get(analytics);

export default router;
