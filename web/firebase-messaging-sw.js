importScripts('https://www.gstatic.com/firebasejs/9.23.0/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/9.23.0/firebase-messaging-compat.js');

// Initialize the Firebase app in the service worker with full web credentials from default firebase options
firebase.initializeApp({
  apiKey: "AIzaSyA9j9yCBhX9MbK1KcV8nxaJOVNWq6Mqa30",
  appId: "1:971935809948:web:4e37cd438e407226bec859",
  messagingSenderId: "971935809948",
  projectId: "vanishlink-app",
  authDomain: "vanishlink-app.firebaseapp.com",
  databaseURL: "https://vanishlink-app-default-rtdb.asia-southeast1.firebasedatabase.app",
  storageBucket: "vanishlink-app.firebasestorage.app"
});

const messaging = firebase.messaging();

messaging.onBackgroundMessage((payload) => {
  console.log('[firebase-messaging-sw.js] Background push payload received: ', payload);
  
  const title = payload.data.title || payload.notification?.title || 'VanishLink';
  const body = payload.data.body || payload.notification?.body || '';

  const options = {
    body: body,
    icon: '/favicon.png',
    tag: payload.data.callId || payload.data.chatId || 'vanish_link_alert',
    data: payload.data
  };

  return self.registration.showNotification(title, options);
});

self.addEventListener('notificationclick', (event) => {
  console.log('[firebase-messaging-sw.js] Notification clicked: ', event.notification.data);
  event.notification.close();

  const data = event.notification.data;
  // Route to the app window
  event.waitUntil(
    clients.matchAll({ type: 'window', includeUncontrolled: true }).then((clientList) => {
      for (const client of clientList) {
        if ('focus' in client) {
          // Send message to open client
          client.postMessage({
            type: 'NOTIFICATION_TAP',
            payload: data
          });
          return client.focus();
        }
      }
      if (clients.openWindow) {
        // Fallback: open window
        let url = '/';
        if (data && data.chatId) {
          url = `/#/chats/${data.chatId}`;
        } else if (data && data.callId) {
          url = `/#/call/${data.callId}`;
        }
        return clients.openWindow(url);
      }
    })
  );
});
