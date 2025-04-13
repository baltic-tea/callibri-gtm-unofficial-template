const injectScript = require('injectScript');
const queryPermission = require('queryPermission');
const copyFromWindow = require('copyFromWindow');
const log = require('logToConsole');

// Loading Callibri script 
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

// Trying to load the script from different CDNs
loadScript(
    "https://gcdn.callibri.ru/callibri.js",
    () => { loadScript("https://cdn.callibri.ru/callibri.js"); }
);