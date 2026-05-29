const pay = () => {
  const publicKey = gon.public_key
  const payjp = Payjp(publicKey) // PAY.JPテスト公開鍵
  const elements = payjp.elements();
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');
  const form = document.getElementById('charge-form')
  form.addEventListener("submit", (e) => {
    e.preventDefault()
    payjp.createToken(numberElement).then(function (response) {
      if (response.error) {
      } else {
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        const input = document.createElement('input');
        input.type = 'hidden';
        input.name = 'purchase_shipping[token]';
        input.value = token;
        form.appendChild(input);
        numberElement.clear();
        expiryElement.clear();
        cvcElement.clear();
        document.getElementById("charge-form").submit();
        form.dataset.sending = 'true'
      }
    });
    
  });
};

window.addEventListener("turbo:load", pay);
window.addEventListener("turbo:render", pay);