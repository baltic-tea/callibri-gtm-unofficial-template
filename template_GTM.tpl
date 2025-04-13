___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Callibri",
  "brand": {
    "id": "brand_dummy",
    "displayName": "",
    "thumbnail": "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAMAAABEpIrGAAAASFBMVEX/yAAAAAD/yAD/yAD/yAD/yAD/yACXdgCIawD/yAAAAAD8xQAJBwAQDAAeFwD4wgB2XQBsVQCDZgBgTABZRgAYEwBOPQAqIQDMz9s0AAAACXRSTlP6AE32woXB/vqYw+rsAAAAp0lEQVQ4y+XTSw7DIAwE0IGQtthAQj7t/W9aPlKRKkMWXXYiJRF+GlaGUtrAioHRSkHNdpBZQYuDe1xrrcZN6n4S0VGEAYT5Rilum/I/pIJIOfUSEay5wD+mHpjwSuAAdxuAuO+WrQTaIUMA7ZL02AFwRD6MAKU4EXDOAPg8GQHXA/4MIXAXtMHvwP8vKCJ8gfMDUBeHF05p3/xeCjDQdhh9ubyX6/8GfkkkrUBrdDIAAAAASUVORK5CYII\u003d"
  },
  "description": {
    "text": "An unofficial template to initialize Callibri platform scripts on your website.",
    "translations": [
      {
        "locale": "ru",
        "text": "Неофициальный шаблон для инициализации скриптов платформы Callibri на вашем сайте."
      }
    ]
  },
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "LABEL",
    "name": "Trigget Hint",
    "displayName": {
      "text": "It is recommended to use the «Initialization - All Pages» trigger with this template.",
      "translations": [
        {
          "locale": "ru",
          "text": "Вместе с этим шаблоном рекомендуется использовать триггер «Initialization - All Pages»."
        }
      ]
    }
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

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


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "inject_script",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urls",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "https://gcdn.callibri.ru/callibri.js"
              },
              {
                "type": 1,
                "string": "https://cdn.callibri.ru/callibri.js"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "debug"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_globals",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "callibriInit"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 13.04.2025, 23:46:19


