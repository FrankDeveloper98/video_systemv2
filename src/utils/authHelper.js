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
export function logout() {
  localStorage.removeItem("token");
  localStorage.removeItem("currentUserRole");
  window.location.href = "/src/login/login.html";
}
