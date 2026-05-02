/* ──────────────────────────────────────────────────────────
   3.  CART — localStorage-based persistence
────────────────────────────────────────────────────────── */

function getCart() {
  const raw = localStorage.getItem("sw_cart");
  return raw ? JSON.parse(raw) : [];
}

function saveCart(cart) {
  localStorage.setItem("sw_cart", JSON.stringify(cart));
}

/* ================= ADD TO CART ================= */

function addToCart(id, name, price, qty, category) {
  const cart = getCart();

  const existing = cart.find(item => item.id === id);

  if (existing) {
    // ✅ FIX: prevent string concatenation
    existing.qty = parseInt(existing.qty) + qty;
  } else {
    cart.push({
      id: id,
      name: name,
      price: parseFloat(price),
      qty: parseInt(qty),
      category: category
    });
  }

  saveCart(cart);
  updateCartUI();
  showToast(`✅ "${name}" added to cart!`);
}

/* ================= REMOVE ================= */

function removeFromCart(id) {
  let cart = getCart();
  cart = cart.filter(item => item.id !== id);
  saveCart(cart);
  updateCartUI();
}

/* ================= CLEAR ================= */

function clearCart() {
  saveCart([]);
  updateCartUI();
}

/* ================= COUNT ================= */

function getCartItemCount() {
  return getCart().reduce(
    (sum, item) => sum + parseInt(item.qty),
    0
  );
}

/* ================= TOTAL ================= */

function getCartTotal() {
  return getCart().reduce(
    (sum, item) =>
      sum + (parseFloat(item.price) * parseInt(item.qty)),
    0
  );
}

/* ================= UI UPDATE ================= */

function updateCartUI() {
  const count = getCartItemCount();
  const total = getCartTotal();

  // Header badge
  document.querySelectorAll(".cart-badge").forEach(b => {
    b.textContent = count;
  });

  // Summary list
  const summaryList = document.getElementById("cart-summary-list");
  if (summaryList) {
    const cart = getCart();

    if (cart.length === 0) {
      summaryList.innerHTML = "<li>Cart is empty</li>";
    } else {
      summaryList.innerHTML = cart.map(item =>
        `<li>
          <span>${item.name} ×${item.qty}</span>
          <span>${(item.price * item.qty).toFixed(2)} DA</span>
        </li>`
      ).join("");
    }
  }

  // Total
  const totalEl = document.getElementById("aside-total");
  if (totalEl) totalEl.textContent = total.toFixed(2) + " DA";

  // Count
  const countEl = document.getElementById("aside-count");
  if (countEl) countEl.textContent = count;

  // Checkout total
  const checkoutTotal = document.getElementById("checkout-total");
  if (checkoutTotal) checkoutTotal.textContent = total.toFixed(2) + " DA";
}

/* ================= ADD BUTTON ================= */

function handleAddToCart(btn) {
  const id       = btn.dataset.id;
  const name     = btn.dataset.name;
  const price    = parseFloat(btn.dataset.price);
  const category = btn.dataset.category || "";

  const qtyInput = btn.parentElement.querySelector("input[type='number']");
  const qty = qtyInput
    ? Math.max(1, parseInt(qtyInput.value) || 1)
    : 1;

  addToCart(id, name, price, qty, category);

  btn.classList.add("added");
  btn.textContent = "Added ✓";

  setTimeout(() => {
    btn.classList.remove("added");
    btn.textContent = "Add to Cart";
  }, 1500);
}

/* ================= CHECKOUT ================= */

function handleCheckout() {
  const cart  = getCart();
  const total = getCartTotal();

  if (cart.length === 0) {
    showToast("⚠️ Your cart is empty!");
    return;
  }

  fetch("save_order.php", {
    method: "POST",
    headers: {
      "Content-Type": "application/json"
    },
    body: JSON.stringify({ cart: cart })
  })
  .then(res => res.json())
  .then(data => {

    if (data.success) {

      const confirmEl = document.getElementById("order-confirmation");
      if (confirmEl) {
        confirmEl.textContent =
          `✅ Order saved! Total: ${total.toFixed(2)} DA`;
        confirmEl.classList.add("visible");
      }

      clearCart();

    } else {
      showToast("❌ " + (data.error || "Error"));
    }

  })
  .catch(() => {
    showToast("❌ Server error");
  });
}

/* ================= TOAST ================= */

function showToast(message) {
  let toast = document.getElementById("sw-toast");

  if (!toast) {
    toast = document.createElement("div");
    toast.id = "sw-toast";
    document.body.appendChild(toast);
  }

  toast.textContent = message;
  toast.classList.add("show");

  setTimeout(() => {
    toast.classList.remove("show");
  }, 2500);
}

/* ================= INIT ================= */

document.addEventListener("DOMContentLoaded", () => {

  document.querySelectorAll(".btn-add-cart").forEach(btn => {
    btn.addEventListener("click", () => handleAddToCart(btn));
  });

  const checkoutBtn = document.getElementById("checkout-btn");
  if (checkoutBtn) {
    checkoutBtn.addEventListener("click", handleCheckout);
  }

  updateCartUI();
});
