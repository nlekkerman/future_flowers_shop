console.log('home.js loaded');


import { fetchAndStoreSeeds} from './control.js';

window.onload = async () => {
    await fetchAndStoreSeeds(); // Fetch and store seeds on page load
   
   
}