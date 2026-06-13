const price = () => {
  const priceInput = document.getElementById("item-price");

  if (!priceInput) return;

  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    const addTaxPrice = document.getElementById("add-tax-price");
    const profit = document.getElementById("profit");

    const tax = Math.floor(inputValue * 0.1);
    const profitValue = Math.floor(inputValue - tax);

    addTaxPrice.innerHTML = tax;
    profit.innerHTML = profitValue;
  });
};

window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);

