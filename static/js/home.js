// home.js
import { fetchAndStoreSeeds, fetchCartData } from './control.js';

window.onload = async () => {
    try {
        // Fetch and store seeds
        await fetchAndStoreSeeds();
        await fetchCartData();
        // Additional logic can be added here once the seeds and user/session are fetched
    } catch (error) {
        console.error('Error during onload initialization:', error);
    }
};

