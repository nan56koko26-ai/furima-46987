const price = () => {
  const priceInput = document.getElementById('item-price');
  const priceDisplay = document.querySelector('.item-price-text, .item-payment-price');
  const addTaxDom = document.getElementById('add-tax-price');
  const addProfitDom = document.getElementById('profit');
  if (!addTaxDom && !addProfitDom) return;
  const calculateAndRender = (num) => {
    const value = Number(String(num).replace(/[^\d]/g, ''));
    if (Number.isNaN(value) || value <= 0) {
      if (addTaxDom) addTaxDom.textContent = '';
      if (addProfitDom) addProfitDom.textContent = '';
      return;
    }
    const tax = Math.floor(value * 0.1);
    const profit = value - tax;
    if (addTaxDom) addTaxDom.textContent = tax;
    if (addProfitDom) addProfitDom.textContent = profit;
  };
  if (priceInput) {
    if (!priceInput.dataset.listenerAttached) {
      priceInput.addEventListener('input', () => {
        calculateAndRender(priceInput.value);
      });
      priceInput.dataset.listenerAttached = 'true';
    }
    calculateAndRender(priceInput.value);
    return;
    }
    if (priceDisplay) {
      const rawText = priceDisplay.textContent.trim();
      calculateAndRender(rawText);
    }
  };


window.addEventListener("turbo:load", price);