import UIKit

@objc(NotificationsOpener) class NotificationsOpener : CDVPlugin {
  @objc(open:)
  func open(command: CDVInvokedUrlCommand) {
    var pluginResult = CDVPluginResult(
      status: CDVCommandStatus_ERROR
    )

    NSLog("NotificationsOpener: open initiated")

    var urlString: String
    if #available(iOS 11.0, *), let bundleIdentifier = Bundle.main.bundleIdentifier {
        NSLog("NotificationsOpener: iOS 11.0+ detected, using custom URL with bundle identifier")
        urlString = "app-settings:root=NOTIFICATIONS_ID&path=\(bundleIdentifier)"
    } else {
        NSLog("NotificationsOpener: iOS < 11.0 detected, using general app settings URL")
        urlString = UIApplicationOpenSettingsURLString
    }

    NSLog("NotificationsOpener: attempting to open URL: \(urlString)")

    guard let url = URL(string: urlString) else {
      NSLog("NotificationsOpener: Failed to create URL")
      self.commandDelegate!.send(
        pluginResult,
        callbackId: command.callbackId
      )
      return
    }

    DispatchQueue.main.async {
      UIApplication.shared.open(url, options: [:], completionHandler: {
        (success) in
        if success {
          NSLog("NotificationsOpener: Successfully opened settings")
          pluginResult = CDVPluginResult(
            status: CDVCommandStatus_OK
          )
        } else {
            NSLog("NotificationsOpener: Failed to open settings")
            pluginResult = CDVPluginResult(
                status: CDVCommandStatus_ERROR,
                messageAs: "Failed to open settings."
            )
        }
        self.commandDelegate!.send(
          pluginResult,
          callbackId: command.callbackId
        )
      })
    }
  }
}
