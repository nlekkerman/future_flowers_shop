document.addEventListener('DOMContentLoaded', function () {
    const searchForm = document.getElementById('search-form');
    const searchInput = document.getElementById('searchInput');

    console.log('Search form:', searchForm);
    console.log('Search input:', searchInput);

    searchForm.addEventListener('submit', function(event) {
        const queryValue = searchInput.value;
        console.log('Search query:', queryValue);  // Debugging line

        if (!queryValue) {
            event.preventDefault();  // Prevent form submission if value is not set correctly
            alert('Search input is empty!');
        }
    });
});
