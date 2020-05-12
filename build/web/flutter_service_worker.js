'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "index.html": "7c107d4473ea58cb1ead928a503d5ae6",
"/": "7c107d4473ea58cb1ead928a503d5ae6",
"main.dart.js": "a71eb0ca334e59b2dfc3dbe1bf78cb4b",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "14cc3e24b3ab3f7a0a1adc029c38b3c7",
"assets/LICENSE": "9023f108a7a08e6b59aeb323b36f49f6",
"assets/AssetManifest.json": "3efa5161b2a23b367f4f7b2d56a6c779",
"assets/FontManifest.json": "143f42d976e36ce10856f5bb4efad7c6",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "d21f791b837673851dd14f7c132ef32e",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "bdd8d75eb9e6832ccd3117e06c51f0d3",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "3ca122272cfac33efb09d0717efde2fa",
"assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"assets/assets/images/bacari-white.png": "47273ca2648ee49728738b75524ef78b",
"assets/assets/icons/check.png": "9bb132efbc01cce8269965fb2bcaff9c",
"assets/assets/icons/arrow_right.png": "0dca116481d58ca9ec0f6f57d576fe6a",
"assets/assets/icons/expand_arrow_more.png": "3e74e761727721e3286e0ae6778f59d1",
"assets/assets/icons/arrow_left.png": "530f285ec6b07bba662c55d2c67b97ce",
"assets/assets/icons/expand_arrow_less.png": "7c8a126758b25ea00224832f8b67b2aa",
"assets/assets/icons/allergens/Gluten.png": "24d39d3f7a040e7b7dbc7858ef25734e",
"assets/assets/icons/allergens/Truffle.png": "33d6c3d83821c48249f19b41a01fb670",
"assets/assets/icons/allergens/Dairy.png": "cae0fad90766b84e62e6254934b41cd5",
"assets/assets/icons/allergens/Wheat.png": "24d39d3f7a040e7b7dbc7858ef25734e",
"assets/assets/icons/allergens/Soy.png": "bf76a4a6993430a45a5ba3396e263a6f",
"assets/assets/icons/allergens/Shellfish.png": "f57de2abfff9bf6e8aa8384f736ec3de",
"assets/assets/icons/allergens/Milk.png": "cae0fad90766b84e62e6254934b41cd5",
"assets/assets/icons/allergens/Onion.png": "4ad373780472eb4b5a6fce8487079c36",
"assets/assets/icons/allergens/Treenuts.png": "e26c0584641b7e8babecd7c768651bbf",
"assets/assets/icons/allergens/Cilantro.png": "ec02c901afc1b64302a1bce416037ce4",
"assets/assets/icons/allergens/Peanut.png": "41ddd4e84516cb4d0bcf389226597d66",
"assets/assets/icons/allergens/Garlic.png": "15288ce0b07e7a6756f4f9910c1db218",
"assets/assets/icons/allergens/Sesame.png": "5849c4357bac1e11cda5876572df0ccb",
"assets/assets/icons/allergens/Egg.png": "16958d65a6a297c786af67dd307f0b9d",
"assets/assets/icons/allergens/Seeds.png": "59cf0e0e35c73a3743e164223352ebc8",
"assets/assets/icons/allergens/Fish.png": "4d719917ef83ac74c30495c5f9c61d08",
"assets/assets/icons/nomi-white-withword.png": "bbbfb43810cc7021d5bf67c3c212f17e",
"assets/assets/fonts/HKGrotesk-Regular.otf": "bc16cabbffc7677c8f3be908e76ea6a1"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"/",
"index.html",
"assets/LICENSE",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(CORE);
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');

      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }

      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // If the URL is not the the RESOURCE list, skip the cache.
  if (!RESOURCES[key]) {
    return event.respondWith(fetch(event.request));
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

