console.log('home.js loaded');


import { fetchAndStoreSeeds, fetchAndStoreCart} from './control.js';

window.onload = async () => {
    await fetchAndStoreSeeds(); // Fetch and store seeds on page load
    await fetchAndStoreCart();  // Fetch and store cart on page load

   
}