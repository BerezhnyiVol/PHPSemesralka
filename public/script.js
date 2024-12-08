document.addEventListener('DOMContentLoaded', () => {
    const currentPage = window.location.pathname.split('/').pop();

    if (currentPage === 'index.html' || currentPage === '') {
        loadRecipes('');
    }

    if (currentPage === 'admin.html') {
        loadIngredientsList();
        setupRecipeForm();
        loadRecipeList();
    }
});

async function loadRecipes(searchTerm) {
    const container = document.getElementById('recipe-list');
    if (!container) return;
    container.innerHTML = '<p>Загрузка...</p>';

    let url = '/PHPSemesralka/api/recipes.php';
    if (searchTerm) {
        url += '?search=' + encodeURIComponent(searchTerm);
    }

    try {
        const response = await fetch(url);
        const result = await response.json();

        container.innerHTML = '';
        if (result.success && Array.isArray(result.data)) {
            const recipes = result.data;
            if (recipes.length === 0) {
                container.innerHTML = '<p>Рецептов нет.</p>';
                return;
            }

            recipes.forEach(r => {
                const card = document.createElement('div');
                card.classList.add('recipe-card');
                card.innerHTML = `
                    <h3>${r.name}</h3>
                    <p>${r.description || ''}</p>
                    <button onclick="loadRecipe(${r.id})">Просмотреть</button>
                    <button onclick="deleteRecipe(${r.id})">Удалить</button>
                `;
                container.appendChild(card);
            });
        } else {
            container.innerHTML = '<p>Ошибка при загрузке рецептов.</p>';
        }
    } catch (error) {
        console.error('Ошибка при загрузке рецептов:', error);
        container.innerHTML = '<p>Произошла ошибка при загрузке рецептов.</p>';
    }
}

async function loadIngredientsList() {
    console.log('Загрузка ингредиентов...');
    try {
        const response = await fetch('/PHPSemesralka/api/ingredients.php');
        const result = await response.json();
        if (result.success) {
            window.availableIngredients = result.data;
            console.log('Ингредиенты загружены:', window.availableIngredients);
        } else {
            console.error('Ошибка загрузки ингредиентов:', result.message);
            alert('Ошибка загрузки ингредиентов: ' + result.message);
        }
    } catch (error) {
        console.error('Ошибка при загрузке ингредиентов:', error);
        alert('Произошла ошибка при загрузке ингредиентов.');
    }
}

function setupRecipeForm() {
    const form = document.getElementById('recipe-form');
    const ingContainer = document.getElementById('ingredients-container');
    const addIngBtn = document.getElementById('add-ingredient-btn');

    addIngBtn.addEventListener('click', () => {
        console.log('Кнопка "Pridať ingredienciu" нажата');
        addIngredientRow(ingContainer);
    });

    form.addEventListener('submit', async (e) => {
        e.preventDefault();
        const data = formToJSON(form);
        const ingredientsData = collectIngredients(ingContainer);

        if (!data.name.trim()) {
            alert('Название рецепта обязательно');
            return;
        }

        if (ingredientsData.length === 0) {
            alert('Добавьте хотя бы один ингредиент.');
            return;
        }

        data.ingredients = ingredientsData;

        try {
            const response = await fetch('/PHPSemesralka/api/recipes.php', {
                method: 'POST',
                headers: {'Content-Type': 'application/json'},
                body: JSON.stringify(data),
            });

            const result = await response.json();
            if (result.success) {
                alert('Рецепт добавлен с ID=' + result.id);
                form.reset();
                ingContainer.innerHTML = '';
                loadRecipes('');
            } else {
                alert('Ошибка: ' + (result.message || 'Неизвестная ошибка'));
            }
        } catch (error) {
            console.error('Ошибка при добавлении рецепта:', error);
            alert('Произошла ошибка при добавлении рецепта.');
        }
    });
}

function addIngredientRow(container) {
    if (!window.availableIngredients || window.availableIngredients.length === 0) {
        alert('Список ингредиентов пуст. Попробуйте снова.');
        console.error('Список ингредиентов не загружен.');
        return;
    }

    const row = document.createElement('div');
    row.classList.add('ingredient-row');

    const select = document.createElement('select');
    window.availableIngredients.forEach(ing => {
        const opt = document.createElement('option');
        opt.value = ing.id;
        opt.textContent = `${ing.name} (${ing.unit || 'ks'})`;
        select.appendChild(opt);
    });

    const amountInput = document.createElement('input');
    amountInput.type = 'number';
    amountInput.placeholder = 'Množstvo';
    amountInput.required = true;
    amountInput.min = '0';
    amountInput.step = 'any';

    const removeBtn = document.createElement('button');
    removeBtn.type = 'button';
    removeBtn.textContent = 'Odstrániť';
    removeBtn.addEventListener('click', () => container.removeChild(row));

    row.appendChild(select);
    row.appendChild(amountInput);
    row.appendChild(removeBtn);

    container.appendChild(row);
}

function formToJSON(form) {
    const data = {};
    const formData = new FormData(form);
    for (const [key, value] of formData.entries()) {
        data[key] = value.trim();
    }
    return data;
}

function collectIngredients(container) {
    const rows = container.querySelectorAll('.ingredient-row');
    const data = [];
    rows.forEach(row => {
        const select = row.querySelector('select');
        const input = row.querySelector('input');
        if (select && input && input.value.trim()) {
            data.push({
                id: select.value,
                amount: input.value.trim(),
            });
        }
    });
    return data;
}
