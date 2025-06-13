import { isAuthenticated, getCurrentUserRole } from "./authHelper.js";

const pageAccess = [
  {
    path: "/src/admin/dashboard/dashboard.html",
    allowedRoles: [1],
    redirectIfNotAllowed: "/src/movies/movies.html"
  },
  {
    path: "/src/movies/movies.html",
    allowedRoles: [2], 
    redirectIfNotAllowed: "/src/login/login.html"
  },
];

function getPageConfig(path) {
  return pageAccess.find(cfg => path.endsWith(cfg.path));
}

(function globalAuthGuard() {
  if (isAuthenticated()) {
    const role = getCurrentUserRole();
    if (
      role === 1 &&
      !window.location.pathname.startsWith("/src/admin/")
    ) {
      window.location.href = "/src/admin/dashboard/dashboard.html";
      return;
    }
  }

  const config = getPageConfig(window.location.pathname);
  if (!config) return; // No config for this page, do nothing

  if (!isAuthenticated()) {
    window.location.href = config.redirectIfNotAllowed;
    return;
  }
  const role = getCurrentUserRole();
  if (!config.allowedRoles.includes(role)) {
    window.location.href = config.redirectIfNotAllowed;
    return;
  }
})();
