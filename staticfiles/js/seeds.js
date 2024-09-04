document.addEventListener('DOMContentLoaded', () => {
    const seedsContainer = document.querySelector('.seeds-container .row');

    function displaySeeds() {
        const seeds = JSON.parse(localStorage.getItem('seeds')) || [];
        seedsContainer.innerHTML = ''; // Clear previous content

        if (seeds.length > 0) {
            seeds.forEach(seed => {
                const seedCard = document.createElement('div');
                seedCard.className = 'col-md-4 mb-4'; // Bootstrap column classes

                const sunPreferenceMap = {
                    'full_shade': 'Full Shade',
                    'partial_shade': 'Partial Shade',
                    'full_sun': 'Full Sun',
                    'partial_sun': 'Partial Sun'
                };

                const sunPreferenceText = sunPreferenceMap[seed.sun_preference] || 'Unknown';

                let stockClass = '';
                if (seed.in_stock === 0) {
                    stockClass = 'text-danger'; // Red text for out of stock
                } else if (seed.in_stock <= 5) {
                    stockClass = 'text-warning'; // Orange text for low stock
                } else {
                    stockClass = 'text-success'; // Green text for sufficient stock
                }

                seedCard.classList.add('col-12', 'col-sm-6', 'col-md-6', 'col-lg-4', 'mb-4'); // Responsive column classes
                seedCard.innerHTML = `
                    <div class="card seed-card">
                        ${seed.image_url ? `<img src="${seed.image_url}" class="card-img-top" alt="${seed.name}">` : ''}
                        <div class="card-body">
                            <h5 class="card-title">${seed.name}</h5>
                            <p class="card-text"><strong>Scientific Name:</strong> ${seed.scientific_name}</p>
                            <p class="card-text"><strong>Planting Months:</strong> ${seed.planting_months_from} to ${seed.planting_months_to}</p>
                            <p class="card-text"><strong>Flowering Months:</strong> ${seed.flowering_months_from} to ${seed.flowering_months_to}</p>
                            <p class="card-text"><strong>Category:</strong> ${seed.category}</p>
                            <p class="card-text"><strong>Height:</strong> ${seed.height_from} to ${seed.height_to}</p>
                            <p class="card-text"><strong>Sun Preference:</strong> ${sunPreferenceText}</p>
                            <p class="card-text"><strong>Price:</strong> $${seed.price}</p>
                            <p class="card-text"><strong>Discounted Price:</strong> $${seed.discounted_price}</p>
                            <p class="card-text ${stockClass}"><strong>In Stock:</strong> ${seed.in_stock}</p>
                            <div class="d-flex justify-content-center">
                                <button class="btn btn-primary add-to-cart" data-id="${seed.id}" data-name="${seed.name}" data-price="${seed.price}" data-image="${seed.image_url}" data-quantity="1">Add to Cart</button>
                            </div>
                        </div>
                    </div>
                `;

                seedsContainer.appendChild(seedCard);
            });
        } else {
            seedsContainer.innerHTML = '<p>No seed data available.</p>';
        }
    }

    displaySeeds();
});
