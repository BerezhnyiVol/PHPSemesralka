function loadPage(page) {
    // Здесь вы можете использовать AJAX или другой метод для загрузки содержимого страницы
    // Например, если загружаете содержимое с сервера, обновите заголовок так:
    if (page === "about.html") {
        document.querySelector('h1').innerText = "O nás";
    } else {
         document.querySelector('h1').innerText = "Domov";
    }

}


