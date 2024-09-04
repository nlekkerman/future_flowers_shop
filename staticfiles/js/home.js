// Import the function from control.js
import { fetchSeedDataFromDB } from './control.js';

// Call the function on page load
document.addEventListener('DOMContentLoaded', async () => {
    try {
        await fetchSeedDataFromDB();
    } catch (error) {
        console.error('Error fetching seed data:', error);
    }
});
