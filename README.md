# Cordova Plugin Notifications Opener

This Cordova plugin provides a way to open the notification settings for your application on iOS.

## Supported Platforms

- iOS

## Installation

To add this plugin to your Cordova project, run the following command:

```bash
cordova plugin add https://github.com/kevin-dallio/cordova-plugin-notifications-opener.git
```

## Usage

To open the notification settings, use the `cordova.plugins.notificationsOpener.open` method:

```javascript
cordova.plugins.notificationsOpener.open(
    function() {
        console.log('Notification settings opened successfully.');
    },
    function(error) {
        console.error('Failed to open notification settings: ' + error);
    }
);
```

## License

This plugin is licensed under the MIT License.
