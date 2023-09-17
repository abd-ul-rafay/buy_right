import Product from '../models/product.js';
import data from './data.js';

const populateData = async () => {
    try {
        await Product.create(data);
        console.log('data populated');
    } catch (err) {
        console.log(`error: ${err}`);
    }
}

export default populateData;
