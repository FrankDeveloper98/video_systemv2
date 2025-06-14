import api from "./apiHelper";

export function requireAuth(redirectToLogin = true) {
  const token = localStorage.getItem("token");
  if (!token && redirectToLogin) {
    window.location.href = "/src/login/login.html";
    return false;
  }
  return !!token;
}

export function isAuthenticated() {
  return !!localStorage.getItem("token");
}

// Returns the current user role as a string (or null if not set)
export function getCurrentUserRole() {
  const role = localStorage.getItem("currentUserRole");
  try {
    return role ? JSON.parse(role) : null;
  } catch {
    return null;
  }
}

// Removes token and role, then redirects to login
export async function logout() {
  const token = localStorage.getItem("token");
  try {
    if (token) {
      await api.post("/users/logout",{
        email: localStorage.getItem("userEmail")
      });
    }
  } catch (e) {
    console.error("Error during logout:", e);
  }
  localStorage.removeItem("token");
  localStorage.removeItem("currentUserRole");
  window.location.href = "/src/login/login.html";
}
