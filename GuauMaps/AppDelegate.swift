//
//  AppDelegate.swift
//  GuauMaps
//
//  Created by Arnau Rivas Rivas on 29/8/24.
//

import UIKit
import GoogleMaps
import GooglePlaces

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        if let path = Bundle.main.path(forResource: "Configuration", ofType: "plist"),
           let plist = NSDictionary(contentsOfFile: path),
           let apiKey = plist["GoogleMapsApiKey"] as? String {
            GMSServices.provideAPIKey(apiKey)
            GMSPlacesClient.provideAPIKey(apiKey)
        } else {
            print("Error: Could not find or read API key from plist.")
        }
        return true
    }
}
