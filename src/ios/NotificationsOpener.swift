import UIKit

@objc(NotificationsOpener) class NotificationsOpener : CDVPlugin {
  @objc(open:)
  func open(command: CDVInvokedUrlCommand) {
    var pluginResult = CDVPluginResult(
      status: CDVCommandStatus_ERROR
    )

    guard let url = URL(string: UIApplication.openNotificationSettingsURLString) else {
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
          pluginResult = CDVPluginResult(
            status: CDVCommandStatus_OK
          )
        } else {
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
