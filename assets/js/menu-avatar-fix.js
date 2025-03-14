document.addEventListener('DOMContentLoaded', function() {
  // Get the checkbox and potentially problematic avatar elements
  const navToggle = document.getElementById('nav-toggle');
  const avatarElements = document.querySelectorAll('.site-avatar, [class*="avatar"], img[src*="avatar"], img[alt*="avatar"]');

  // Check if elements exist
  if (navToggle && avatarElements.length > 0) {
    // Function to toggle visibility
    function toggleAvatarVisibility() {
      const isMenuOpen = navToggle.checked;
      avatarElements.forEach(function(element) {
        if (isMenuOpen) {
          element.style.opacity = "0";
          element.style.visibility = "hidden";
        } else {
          element.style.opacity = "1";
          element.style.visibility = "visible";
        }
      });
    }

    // Listen for changes to the checkbox state
    navToggle.addEventListener('change', toggleAvatarVisibility);
  }
});
