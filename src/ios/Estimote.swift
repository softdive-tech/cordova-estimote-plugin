
import Foundation

 @objc(HWPEstimote) class Discover : CDVPlugin {
    func greet(command: CDVInvokedUrlCommand) {
        var message = command.arguments[0]
        
        var pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAsString: "Estimote \(message)")
        commandDelegate.sendPluginResult(pluginResult, callbackId:command.callbackId)
    }
}