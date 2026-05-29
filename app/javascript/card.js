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
        console.error(response.error);
      const message = response.error && response.error.message ? response.error.message : "There is an error with your card information.";
      let container = document.getElementById('client-card-errors');
      if (!container) {
      container = document.createElement('div');
      container.id = 'client-card-errors';
      container.className = 'error-alert';
      const ul = document.createElement('ul');
      container.appendChild(ul);
      form.insertBefore(container, form.firstChild);
      }
      const ul = container.querySelector('ul') || (function(){ const t = document.createElement('ul'); container.appendChild(t); return t; })();
      // 既存メッセージをクリアして新しい li を追加（XSS対策で textContent を使う）
      ul.innerHTML = '';
      const li = document.createElement('li');
      li.className = 'error-message';
      li.textContent = message;
      ul.appendChild(li);
      // 表示させる（CSSで非表示にしている場合の解除）
      container.style.display = '';
      // 送信状態を解除して再試行可能にする
      const submitBtn = form.querySelector('input[type="submit"], button[type="submit"]');
      if (submitBtn) submitBtn.disabled = false;
      delete form.dataset.sending;
      // カード番号フィールドにフォーカス（可能なら）
      if (numberElement && typeof numberElement.focus === 'function') numberElement.focus();
      return;
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