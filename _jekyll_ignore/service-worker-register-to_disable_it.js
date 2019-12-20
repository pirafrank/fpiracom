// use this in browser console to unregister all service workers
navigator.serviceWorker.getRegistrations().then(
    function(registrations) {
        for(let registration of registrations) {  
            registration.unregister();
        }
});



// replace the self.addEventListener in service-worker.js with the following code
self.addEventListener("activate", function(e) {
  self.registration.unregister()
	.then(function() {
		return self.clients.matchAll();
	})
	.then(function(clients) {
		clients.forEach(client => client.navigate(client.url));
	});
});


