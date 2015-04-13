import UIKit
import Foundation
import CoreLocation


 @objc(HWPEstimote) class Estimote : CDVPlugin, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager?
    let defaults = NSUserDefaults.standardUserDefaults()
    
    func greet(command: CDVInvokedUrlCommand) {
        var message = command.arguments[0]
        
        var pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAsString: "Estimote \(message)")
        commandDelegate.sendPluginResult(pluginResult, callbackId:command.callbackId)
        
        run()
    }

func run() {
        let uuidString = "7DE848F7-124C-4AC8-968D-23C74B8769D7"
        let beaconIdentifier = "iBeaconModules.us"
        let beaconUUID:NSUUID = NSUUID(UUIDString: uuidString)!
        let beaconRegion:CLBeaconRegion = CLBeaconRegion(proximityUUID: beaconUUID,
            identifier: beaconIdentifier)
    
        beaconRegion.notifyEntryStateOnDisplay = true
        
        locationManager = CLLocationManager()
    
        if(locationManager!.respondsToSelector("requestAlwaysAuthorization")) {
            locationManager!.requestAlwaysAuthorization()
        }
    
        locationManager!.delegate = self
        locationManager!.pausesLocationUpdatesAutomatically = false
        
        locationManager!.startMonitoringForRegion(beaconRegion)
        locationManager!.startRangingBeaconsInRegion(beaconRegion)
        locationManager!.startUpdatingLocation()
        
    }
}

extension Estimote: CLLocationManagerDelegate {
    
    func sendLocalNotificationWithMessage(message: String!) {
        let notification:UILocalNotification = UILocalNotification()
        notification.alertBody = message
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    func locationManager(manager: CLLocationManager!,
        didRangeBeacons beacons: [AnyObject]!,
        inRegion region: CLBeaconRegion!) {
            NSLog("didRangeBeacons");
            var message:String = ""
            
            if(beacons.count > 0) {
                let nearestBeacon:CLBeacon = beacons[0] as! CLBeacon
                
                switch nearestBeacon.proximity {
                case CLProximity.Far:
                    message = "You are far away from the beacon"
                case CLProximity.Near:
                    message = "You are near the beacon"
                case CLProximity.Immediate:
                    message = "You are in the immediate proximity of the beacon"
                case CLProximity.Unknown:
                    return
                }
            } else {
                message = "No beacons are nearby"
            }
            
            NSLog("%@", message)
            //sendLocalNotificationWithMessage(message)
    }
    func writeData(outletId: String){
        
        if let name = defaults.stringForKey("outlets")
        {
            var appendString1 = "\(name),\(outletId)"
            defaults.setObject(appendString1, forKey: "outlets")
            
        }
        else{
            defaults.setObject(outletId, forKey: "outlets")
        }
    }
    func readData(command: CDVInvokedUrlCommand) {
        NSLog("%@", "reached")
        var message: AnyObject = command.arguments[0]
        var pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAsString: "Estimote \(message)")
        commandDelegate.sendPluginResult(pluginResult, callbackId:command.callbackId)
        NSLog("%@", defaults.stringForKey("outlets")!)
    }
    
    func removeData(){
        defaults.removeObjectForKey("outlets")
    }
    
}
