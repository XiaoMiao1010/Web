function addToCart(productName, productPrice) {
    let cart = JSON.parse(localStorage.getItem("cart")) || {};
    if (cart[productName]) {
        cart[productName].quantity += 1;
    } else {
        cart[productName] = {price: parseFloat(productPrice), quantity: 1};
    }
    localStorage.setItem("cart", JSON.stringify(cart));
}

document.querySelectorAll(".add-to-cart").forEach((button) => {
    button.addEventListener("click", () => {
        const name = button.getAttribute("data-name");
        const price = button.getAttribute("data-price");
        addToCart(name, price);
        alert(`${name} 已加入购物车`);
    });
});

function search() {
    let input = document.getElementById('search-item').value.toLowerCase();
    let products = document.querySelectorAll('.product');
    products.forEach(product => {
        let name = product.querySelector('.p-details h2').textContent.toLowerCase();
        if (name.includes(input)) {
            product.style.display = '';
        } else {
            product.style.display = 'none';
        }
    });
}

const search = () => {
    const searchbox = document.getElementById("search-item").value.toUpperCase();
    const storeitems = document.getElementById("product-list")
    const product = document.querySelectorAll(".product")
    const pname = storeitems.getElementsByTagName("h2")

    for (var i = 0; i < pname.length; i++) {
        let match = product[i].getElementsByTagName('h2')[0];

        if (match) {
            let textvalue = match.textContent || match.innerHTML

            if (textvalue.toUpperCase().indexOf(searchbox) > -1) {
                product[i].style.display = "";
            } else {
                product[i].style.display = "none";
            }
        }
    }
}
