document.addEventListener('DOMContentLoaded', function () {
    // Show the splash screen initially
  
    // Simulate a delay (e.g., 2 seconds) before hiding the splash screen
    setTimeout(hideSplashScreen, 2000);
  
    // Add an event listener to hide the splash screen when the page is navigated away and back
    window.addEventListener('pageshow', function(event) {
        if (event.persisted) {
            hideSplashScreen();
        }
    });
});

function hideSplashScreen() {
    // Hide the splash screen
    document.getElementById('splash-screen').style.display = 'none';
}
