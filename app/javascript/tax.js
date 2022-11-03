window.addEventListener("load", () => {
  const itemPrice = document.getElementById("item-price")
  itemPrice.addEventListener('input', () => {
    document.getElementById("add-tax-price").innerHTML = Math.floor(itemPrice.value*0.1)
    document.getElementById("profit").innerHTML = itemPrice.value-Math.floor((itemPrice.value*0.1))
  })
})