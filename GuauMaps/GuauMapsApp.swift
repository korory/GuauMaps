//
//  GuauMapsApp.swift
//  GuauMaps
//
//  Created by Arnau Rivas Rivas on 29/8/24.
//

import SwiftUI

@main
struct GuauMapsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
