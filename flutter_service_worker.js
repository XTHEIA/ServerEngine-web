'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"spinner.css": "a21192a2c6b43ec6a123a3713be85a4c",
"icons/Icon-192.png": "5551cbb18f0f75eb66a9686bf7c4ac5c",
"icons/favicon.png": "50230df9f4e565b806fd79d039c63565",
"icons/favicon.ico": "f7a16b4396f981526bdc87ed03601270",
"CNAME": "2573d606f55f71a80c8186cf4227d810",
"logo.png": "d2d540829d3a255f0684d2ff8979700c",
"manifest.json": "8e2d53a4b3b75a29253103afae87682c",
"canvaskit/canvaskit.js": "738255d00768497e86aa4ca510cce1e1",
"canvaskit/canvaskit.js.symbols": "74a84c23f5ada42fe063514c587968c6",
"canvaskit/chromium/canvaskit.js": "901bb9e28fac643b7da75ecfd3339f3f",
"canvaskit/chromium/canvaskit.js.symbols": "ee7e331f7f5bbf5ec937737542112372",
"canvaskit/chromium/canvaskit.wasm": "399e2344480862e2dfa26f12fa5891d7",
"canvaskit/canvaskit.wasm": "9251bb81ae8464c4df3b072f84aa969b",
"canvaskit/skwasm.wasm": "4051bfc27ba29bf420d17aa0c3a98bce",
"canvaskit/skwasm.js.symbols": "c3c05bd50bdf59da8626bbe446ce65a3",
"canvaskit/skwasm.js": "5d4f9263ec93efeb022bb14a3881d240",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"flutter.js": "383e55f7f3cce5be08fcf1f3881f585c",
"app_ads.json": "999bf8b6c090331d59e5abc92fc787f9",
"flutter_bootstrap.js": "5f790bf90a103b589ff378d605f94620",
"version.json": "7870b3f70f64c76af6714affc4198ae8",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/NOTICES": "ff02e8d88f0b872effb903f80447eb33",
"assets/AssetManifest.bin": "c01906fd8471fa9473bb1f80352c428b",
"assets/FontManifest.json": "022d84ed07677802a9213b9e94fde598",
"assets/AssetManifest.bin.json": "dface119926da3da615e06bd344491ef",
"assets/assets/image/feature/serverIcon.png": "6986d3f7d004618882fc69dc7c28a56a",
"assets/assets/image/feature/serverProperties0.png": "5335cab583d4f05a2c91d040677b6bfd",
"assets/assets/image/feature/runConsole.png": "b5870753f5453230288d15bcff8d757f",
"assets/assets/image/feature/itemGiver.png": "c8eed615a437b252c9fe031b906d5343",
"assets/assets/image/feature/players.png": "d9ed8a5e9574decbe54c3642882e5f53",
"assets/assets/image/feature/plugins.png": "2f89a71093892ed46198d5e33cd0e508",
"assets/assets/image/feature/javaDetail.png": "f16e94b268ac2bfcab8a924c48b6cc04",
"assets/assets/image/feature/listPing.png": "5bd382552e519b5407c20e7c16946dce",
"assets/assets/image/feature/discordRpc.png": "72c8a6f6b4bc6dea8d84689b34cefe94",
"assets/assets/image/feature/serverCreationPaper.png": "2e90b8ac925252c2dd247f05e4f039db",
"assets/assets/image/feature/ngrokInstances.png": "e4efaad40526d218d944b7dba6c44061",
"assets/assets/image/feature/playerData.png": "376bbc5aa102ed02241b9333df3bd581",
"assets/assets/image/feature/events.png": "b0e08603d250f27beaa4837b4984f3a4",
"assets/assets/image/feature/serverProperties1.png": "5b7e0e2ab5a7313660ebfe0259b04a91",
"assets/assets/image/feature/worldCommands.png": "60290c64892e79295dd3dc0ec32c4430",
"assets/assets/image/feature/runWait.png": "f0bad6b76ed496bae4c05e8e81fa44d4",
"assets/assets/image/feature/java.png": "f81d050a58ac8d6dbd744fff1202bdd7",
"assets/assets/image/feature/playerCommands.png": "1123611ec6be5ca9f3e94bcaaca28977",
"assets/assets/image/feature/configRun.png": "370acb7335fc00b852bf09bfac3c96d7",
"assets/assets/image/feature/ngrokRun.png": "b877d3cd33ac5586569a9e04ad17b577",
"assets/assets/image/feature/eula.png": "41daac24d1c70ab29f565092d30716fe",
"assets/assets/image/logo.png": "d2d540829d3a255f0684d2ff8979700c",
"assets/assets/image/tutorial/win/unzip.png": "b276e3b4e576f5b02c8dc87c5ec8ea0a",
"assets/assets/image/tutorial/win/unzipped.png": "406bb19ac37eacc3f0da0ebf850b06dd",
"assets/assets/image/tutorial/win/download.png": "6c327fad28751f8fd781ead402318864",
"assets/assets/image/screen/ngrokStarter0.png": "7795711491aee408e63b7c837a228c7d",
"assets/assets/image/screen/config.png": "5f6b53409241a3ca4bad19d6ab9775a1",
"assets/assets/image/screen/serverIcon.png": "f00e552d1174858c3dc435d77866bebb",
"assets/assets/image/screen/players.png": "3c48e83890ccd9e7eb84ab71358c2ec6",
"assets/assets/image/screen/main.png": "4db5de5c3239f67e3f29f0c57522f074",
"assets/assets/image/screen/paperDownloader.png": "2d06291cbd4d6e5ce15ef365eb15c16f",
"assets/assets/image/screen/plugins.png": "673bec0221322ccc86c317c28241548d",
"assets/assets/image/screen/settingSave.png": "a9866ce710ddef07d9c407a6e8cc5a65",
"assets/assets/image/screen/runConsole1.png": "ff81ed9cd13fb52ac1633e1bcf060d26",
"assets/assets/image/screen/listPing.png": "d8ee050fabe72d56c22c27264a4bec2e",
"assets/assets/image/screen/serverCreationPaper.png": "f933a79d748897f753c01c86f7a68bf7",
"assets/assets/image/screen/runConsole0.png": "7176e1796432c70b4ab80011b5087a2b",
"assets/assets/image/screen/serverCreations.png": "3b5b861c939ce8f9aae275b5cef0685d",
"assets/assets/image/screen/langs.png": "4d2f86227e4f46e596c42f854f8888dd",
"assets/assets/image/screen/ngrokInstances.png": "81ae31fffeb56a73c5801d00582fb8b9",
"assets/assets/image/screen/itemgiver.png": "ff46a25da67e15a2b088ae6fbc10cf75",
"assets/assets/image/screen/playerData.png": "cba4f18592d7758bf672bbc461ee60c1",
"assets/assets/image/screen/events.png": "a893ec491825def81037837ac9d63d78",
"assets/assets/image/screen/javas.png": "4a66f03237e3e9f6a7263d6e99692bc6",
"assets/assets/image/screen/worldCommands.png": "3d08675fbe2985d3c3cbabfd261e7cfb",
"assets/assets/image/screen/runWait.png": "e6b7e02f49e4c8eded6ab7022e1250a3",
"assets/assets/image/screen/worlds.png": "ca568f4baea4e2a75af23cf7b38437c8",
"assets/assets/image/screen/serverProperties.png": "7121f734cf93e7c4dbfb3ee9794bd85e",
"assets/assets/image/screen/playerActions.png": "bc2f8bca92bfe373ad3d3646d1c36373",
"assets/assets/image/screen/configRun.png": "0018f10aaa778f73116c05ea2ed11f2d",
"assets/assets/image/screen/configAdvanced.png": "f5df714d4e840e5dcb74e14e069f7862",
"assets/assets/image/screen/ngrokRun.png": "3e91373d544ff000b3339b5cd0f29648",
"assets/assets/image/screen/eula.png": "473a4997e1c3e90a06519cba71a16da1",
"assets/assets/fonts/Pretendard-Bold.ttf": "dfb614ebecd405875f50a918ca11c17c",
"assets/assets/fonts/NotoSansKR-Regular.ttf": "e910afbd441c5247227fb4a731d65799",
"assets/assets/fonts/NanumBarunGothic.ttf": "0384532820e984ca0dc4a140d11b12d4",
"assets/assets/fonts/NotoSansKR-Bold.ttf": "671db5f821991c90d7f8499bcf9fed7e",
"assets/assets/fonts/JetBrainsMonoNL-Regular.ttf": "0dc7ccd81c27e2fca57bebda54e11e09",
"assets/assets/fonts/Pretendard-Regular.ttf": "d6e0de06bff8b7fda2db4682168e3ddf",
"assets/assets/fonts/NanumBarunGothicBold.ttf": "3b18e24ea5237f4d6e2731c17ca7f164",
"assets/assets/fonts/Pretendard-Medium.ttf": "7305f90c923d4409825ec2f4380b63d6",
"assets/assets/fonts/JetBrainsMonoNL-Bold.ttf": "287bc4c006a0f04e56c372857e8a74d1",
"assets/fonts/MaterialIcons-Regular.otf": "163e3bbf236d19cc077f03ba52afbf0d",
"assets/AssetManifest.json": "b2757610ba5665f16018baa6f7efeca2",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"index.html": "a7cbca074dbcb4d62bcae755dfe53dcb",
"/": "a7cbca074dbcb4d62bcae755dfe53dcb",
"main.dart.js": "7997fecf78211479c3cc6502d49b117c"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
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
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
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
      // Claim client to enable caching on first launch
      self.clients.claim();
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
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
