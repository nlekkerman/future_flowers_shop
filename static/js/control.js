console.log('control.js loaded'); // Log when this script is loaded

export async function fetchAndStoreSeeds() {
    try {
        const response = await fetch('/syncmanager/api/get_seeds_to_localstorage/');
        if (!response.ok) {
            const responseBody = await response.text();
            throw new Error(`Failed to fetch seeds: ${response.statusText}. Response body: ${responseBody}`);
        }
        const data = await response.json();
        console.log('Fetched all seeds from server:', data.seeds);

        if (!Array.isArray(data.seeds)) {
            throw new Error('Expected `seeds` to be an array');
        }

        localStorage.setItem('seeds_data', JSON.stringify(data.seeds));
        console.log('Seeds data saved to localStorage.');

        // Return the data for use in other functions
        return data.seeds; // Return the array of seeds
    } catch (error) {
        console.error('Error fetching and storing seeds:', error);
        // Optionally return empty array or handle the error accordingly
        return [];
    }
}



