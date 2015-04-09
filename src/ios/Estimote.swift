
import Foundation

 @objc(HWPEstimote) class Discover : CDVPlugin {
    func greet(command: CDVInvokedUrlCommand) {
        var message = command.arguments[0] as String
        
        var pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAsString: "Estimote \(message)")
        commandDelegate.sendPluginResult(pluginResult, callbackId:command.callbackId)
    }
}