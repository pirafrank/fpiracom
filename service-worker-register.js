// use this in browser console to unregister all service workers
navigator.serviceWorker.getRegistrations().then(
    function(registrations) {
			  var i=0
				for(i; i<registrations.length; i++) {
						registrations[i].unregister();
        }
});



// replace the self.addEventListener in service-worker.js with the following code
self.addEventListener("activate", function(e) {
  self.registration.unregister()
	.then(function() {
		return self.clients.matchAll();
	})
	.then(function(clients) {
    clients.forEach(function (client) {
      return client.navigate(client.url);
    });
	});
});


