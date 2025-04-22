const injectScript = require('injectScript');
const queryPermission = require('queryPermission');
const copyFromWindow = require('copyFromWindow');
const log = require('logToConsole');

// Load script 
function loadScript(url, onFailure) {
  if (queryPermission('inject_script', url)) {
    onFailure = onFailure || data.gtmOnFailure;
    injectScript(
      url,
      () => {
        log("⬇️ Callibri: Loaded script from " + url);
        if (typeof copyFromWindow("callibriInit") === 'function') {
          log("✅ Callibri: Script initialized successfully");
          data.gtmOnSuccess();
        } else {
          onFailure();
        }
      },
      () => {
        log("❌ Callibri: Failed to load Callibri script from " + url);
        onFailure();
      },
      url
    );
  }
}

// Retry to load the script from a different URL
function retryLoadScript() {
  var url = "https://cdn.callibri.ru/callibri.js";
  log("⚠️ Callibri: Script will be loaded from " + url);
  log("⚠️ When integrating Callibri via GTM, it is recommended to load the script from gcdn.callibri.ru/callibri.js");
  loadScript(url);
}

loadScript(
  "https://gcdn.callibri.ru/callibri.js",
  retryLoadScript
);
