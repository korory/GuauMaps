//
//  MainView.swift
//  GuauMaps
//
//  Created by Arnau Rivas Rivas on 29/8/24.
//

import SwiftUI
import CoreLocation

struct MainView: View {
    
    var body: some View {
        VStack {
            MapView()
                .edgesIgnoringSafeArea(.all)
        }
    }
}
