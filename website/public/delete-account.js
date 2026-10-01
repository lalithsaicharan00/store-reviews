// Deleting an account without the app (Google Play requires a web way; Architecture 09 §7).
// Sign in with Google (the web OAuth client), then the same API calls the app makes: /v1/auth/google, then
// /v1/account/delete. Nothing is stored in the browser.
(() => {
  const WEB_CLIENT_ID = "367584981284-i2afctg5t1d702fch3300d4vacp3teod.apps.googleusercontent.com";
  const live = location.hostname === "oftenenough.com" || location.hostname === "www.oftenenough.com"; // anywhere else (site-dev) uses the dev API
  const API = live ? "https://api.oftenenough.com" : "https://api-dev.oftenenough.com";
  const $ = (id) => document.getElementById(id);
  let rawNonce = "";
  let accessToken = null;

  const showError = (text) => { $("error").textContent = text; $("error").hidden = !text; };
  const step = (name) => { for (const s of ["sign-in", "confirm", "done"]) $(`step-${s}`).hidden = s !== name; };

  async function sha256Hex(text) {
    const digest = await crypto.subtle.digest("SHA-256", new TextEncoder().encode(text));
    return [...new Uint8Array(digest)].map((b) => b.toString(16).padStart(2, "0")).join("");
  }

  function emailOf(idToken) {
    try {
      const payload = idToken.split(".")[1].replace(/-/g, "+").replace(/_/g, "/");
      return JSON.parse(decodeURIComponent(escape(atob(payload)))).email || "your Google account";
    } catch {
      return "your Google account";
    }
  }

  async function post(path, body, token) {
    const response = await fetch(API + path, {
      method: "POST",
      headers: { "content-type": "application/json", ...(token ? { authorization: `Bearer ${token}` } : {}) },
      body: JSON.stringify(body ?? {}),
    });
    let json = {};
    try { json = await response.json(); } catch { /* empty */ }
    return { status: response.status, json };
  }

  async function onCredential(response) {
    showError("");
    try {
      const device = { id: crypto.randomUUID(), platform: "web", name: "Website", appVersion: "web" };
      const signedIn = await post("/v1/auth/google", { idToken: response.credential, nonce: rawNonce, device });
      if (signedIn.status === 404) return showError("There's no Often Enough account for this Google account. If you used Apple, delete it in the app.");
      if (signedIn.status !== 200) return showError("Couldn't sign in. Please try again.");
      accessToken = signedIn.json.accessToken;
      $("who").textContent = emailOf(response.credential);
      $("understand").checked = false;
      $("delete").disabled = true;
      step("confirm");
    } catch {
      showError("Couldn't reach our server. Check your connection and try again.");
    }
  }

  $("understand").addEventListener("change", () => { $("delete").disabled = !$("understand").checked; });

  $("delete").addEventListener("click", async () => {
    showError("");
    $("delete").disabled = true;
    try {
      const result = await post("/v1/account/delete", {}, accessToken);
      if (result.status !== 200) {
        $("delete").disabled = false;
        return showError("Couldn't delete the account. Nothing was changed; please try again.");
      }
      accessToken = null;
      const goneBy = new Date(Date.now() + 30 * 86400000);
      $("gone-by").textContent = goneBy.toLocaleDateString(undefined, { day: "numeric", month: "long", year: "numeric" });
      step("done");
    } catch {
      $("delete").disabled = false;
      showError("Couldn't reach our server. Nothing was changed; please try again.");
    }
  });

  // Cancel leaves no session behind.
  $("cancel").addEventListener("click", async () => {
    const token = accessToken;
    accessToken = null;
    step("sign-in");
    if (token) { try { await post("/v1/account/signout", {}, token); } catch { /* the session expires anyway */ } }
  });

  async function startGoogle() {
    rawNonce = crypto.randomUUID() + crypto.randomUUID();
    window.google.accounts.id.initialize({
      client_id: WEB_CLIENT_ID,
      callback: onCredential,
      nonce: await sha256Hex(rawNonce), // the server checks SHA-256(nonce) is in the token
      auto_select: false,
      cancel_on_tap_outside: true,
    });
    window.google.accounts.id.renderButton($("google-button"), { theme: "outline", size: "large", text: "signin_with", shape: "pill" });
    $("google-loading").hidden = true;
  }

  // Google's script loads after this one.
  let tries = 0;
  (function wait() {
    if (window.google?.accounts?.id) return void startGoogle();
    if (++tries > 100) { $("google-loading").textContent = "Google sign-in didn't load. Check your connection, or turn off blockers for this page."; return; }
    setTimeout(wait, 100);
  })();
})();
