const pay = () => {
  const form = document.getElementById("charge-form");
  if (!form) return;

  const payjp = Payjp(gon.public_key);
  const elements = payjp.elements();

  const numberElement = elements.create("cardNumber");
  const expiryElement = elements.create("cardExpiry");
  const cvcElement = elements.create("cardCvc");

  numberElement.mount("#number-form");
  expiryElement.mount("#expiry-form");
  cvcElement.mount("#cvc-form");

  form.addEventListener("submit", (event) => {
    event.preventDefault();

    payjp.createToken(numberElement).then((response) => {
      if (response.error) {
        return;
      }

      const token = response.id;
      const tokenObj = `<input value="${token}" name="token" type="hidden">`;

      form.insertAdjacentHTML("beforeend", tokenObj);

      numberElement.clear();
      expiryElement.clear();
      cvcElement.clear();

      form.submit();
    });
  });
};

window.addEventListener("turbo:load", pay);