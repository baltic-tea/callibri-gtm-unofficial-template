// Copyright 2025 baltic_tea

// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at

//     https://www.apache.org/licenses/LICENSE-2.0

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "TAG",
  "id": "callibri_unofficial",
  "version": 1,
  "securityGroups": [],
  "displayName": "Callibri",
  "brand": {
    "id": "callibri",
    "displayName": "Callibri",
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
  "categories": [
    "LEAD_GENERATION",
    "ANALYTICS",
    "ADVERTISING"
  ],
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


