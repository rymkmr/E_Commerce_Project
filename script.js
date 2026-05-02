
/* ──────────────────────────────────────────────────────────
   3.  CART — localStorage-based persistence
   Cart structure in localStorage key "sw_cart":
   [ { id, name, price, qty, category }, ... ]
   ────────────────────────────────────────────── */

/**
 * Get the cart array from localStorage.
 * Returns an empty array if nothing is stored yet.
 */
function getCart() {
  const raw = localStorage.getItem("sw_cart");
  return raw ? JSON.parse(raw) : [];
}

/**
 * Save the cart array back to localStorage.
 */
function saveCart(cart) {
  localStorage.setItem("sw_cart", JSON.stringify(cart));
}

/**
 * Add a product to the cart (or increase its quantity).
 * @param {string} id       - unique product ID
 * @param {string} name     - product name
 * @param {number} price    - unit price
 * @param {number} qty      - quantity to add
 * @param {string} category - product category
 */
function addToCart(id, name, price, qty, category) {
  const cart = getCart();

  const existing = cart.find(item => item.id === id);

  if (existing) {
    existing.qty += qty;           // increase quantity
  } else {
    cart.push({ id, name, price, qty, category }); // add new item
  }

  saveCart(cart);
  updateCartUI();
  showToast(`✅ "${name}" added to cart!`);
}

/**
 * Remove an item from the cart by its ID.
 */
function removeFromCart(id) {
  let cart = getCart();
  cart = cart.filter(item => item.id !== id);
  saveCart(cart);
  updateCartUI();
}

/**
 * Clear the entire cart.
 */
function clearCart() {
  saveCart([]);
  updateCartUI();
}

/**
 * Calculate total number of items in the cart.
 */
function getCartItemCount() {
  return getCart().reduce((sum, item) => sum + item.qty, 0);
}

/**
 * Calculate the total price of the cart.
 */
function getCartTotal() {
  return getCart().reduce((sum, item) => sum + item.price * item.qty, 0);
}

/**
 * Update elements on the page:
 */
function updateCartUI() {
  const count = getCartItemCount();
  const total = getCartTotal();

  // ── Header badge ──
  const badges = document.querySelectorAll(".cart-badge");
  badges.forEach(b => { b.textContent = count; });

  // ── Aside cart summary ──
  const summaryList = document.getElementById("cart-summary-list");
  if (summaryList) {
    const cart = getCart();

    if (cart.length === 0) {
      summaryList.innerHTML = "<li style='color:var(--clr-muted)'>Cart is empty</li>";
    } else {
      summaryList.innerHTML = cart.map(item =>
        `<li>
          <span>${item.name} ×${item.qty}</span>
          <span>${(item.price * item.qty).toFixed(2)} DA</span>
        </li>`
      ).join("");
    }
  }

  // ── Aside total ──
  const totalEl = document.getElementById("aside-total");
  if (totalEl) totalEl.textContent = total.toFixed(2) + " DA";

  // ── Aside item count badge ──
  const countEl = document.getElementById("aside-count");
  if (countEl) countEl.textContent = count;

  // ── Checkout bar ──
  const checkoutTotal = document.getElementById("checkout-total");
  if (checkoutTotal) checkoutTotal.textContent = total.toFixed(2) + " DA";
}

/* ──────────────────────────────────────────────────────────
   4.  "ADD TO CART" BUTTON HANDLER
   Reads quantity input next to the button.
   ────────────────────────────────────────────────────────── */

/**
 * Called when any "Add to Cart" button is clicked.
 * Reads data attributes from the button itself.
 * @param {HTMLButtonElement} btn - the clicked button element
 */
function handleAddToCart(btn) {
  const id       = btn.dataset.id;
  const name     = btn.dataset.name;
  const price    = parseFloat(btn.dataset.price);
  const category = btn.dataset.category || "";

  // Find the sibling quantity input
  const qtyInput = btn.parentElement.querySelector("input[type='number']");
  const qty = qtyInput ? parseInt(qtyInput.value) || 1 : 1;

  if (qty < 1) return;

  addToCart(id, name, price, qty, category);

  // Visual feedback on button
  btn.classList.add("added");
  btn.textContent = "Added ✓";
  setTimeout(() => {
    btn.classList.remove("added");
    btn.textContent = "Add to Cart";
  }, 1500);
}

/* ──────────────────────────────────────────────────────────
   5.  CHECKOUT
   ────────────────────────────────────────────────────────── */

/**
 * Handle checkout button click.
 * Displays the total and a confirmation message.
 * In a real app this would POST to save_order.php.
 */
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
        confirmEl.textContent = `✅ Order saved! Total: ${total.toFixed(2)} DA`;
        confirmEl.classList.add("visible");
      }

      clearCart();

    } else {
      showToast("❌ " + data.error);
    }

  })
  .catch(() => {
    showToast("❌ Server error");
  });
}

/* ──────────────────────────────────────────────────────────
   6.  TOAST NOTIFICATION
   ────────────────────────────────────────────────────────── */

/**
 * Show a brief toast popup at the bottom-right of the screen.
 * @param {string} message - text to display
 */
function showToast(message) {
  let toast = document.getElementById("sw-toast");

  // Create toast element if it doesn't exist yet
  if (!toast) {
    toast = document.createElement("div");
    toast.id = "sw-toast";
    toast.className = "toast";
    document.body.appendChild(toast);
  }

  toast.textContent = message;
  toast.classList.add("show");

  // Auto-hide after 2.5 seconds
  setTimeout(() => { toast.classList.remove("show"); }, 2500);
}

/* ──────────────────────────────────────────────────────────
   7.  PAGE INIT — runs when DOM is ready
   ────────────────────────────────────────────────────────── */
document.addEventListener("DOMContentLoaded", () => {
  // ── "Add to Cart" buttons ──
  document.querySelectorAll(".btn-add-cart").forEach(btn => {
    btn.addEventListener("click", () => handleAddToCart(btn));
  });

  // ── Checkout button ──
  const checkoutBtn = document.getElementById("checkout-btn");
  if (checkoutBtn) {
    checkoutBtn.addEventListener("click", handleCheckout);
  }

  // ── Initial cart UI refresh ──
  updateCartUI();
});
