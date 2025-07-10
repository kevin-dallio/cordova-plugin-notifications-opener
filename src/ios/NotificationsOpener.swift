import UIKit

@objc(NotificationsOpener) class NotificationsOpener : CDVPlugin {
  @objc(open:)
  func open(command: CDVInvokedUrlCommand) {
    var pluginResult = CDVPluginResult(
      status: CDVCommandStatus_ERROR
    )

    var urlString: String
    if #available(iOS 16.0, *) {
        urlString = UIApplication.openNotificationSettingsURLString
    } else {
        urlString = UIApplication.openSettingsURLString
    }

    guard let url = URL(string: urlString) else {
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
