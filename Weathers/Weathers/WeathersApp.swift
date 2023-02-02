//
//  WeathersApp.swift
//  Weathers
//
//  Created by xindy.del.rosario on 1/31/23.
//

import SwiftUI

@main
struct WeathersApp: App {
    var body: some Scene {
        WindowGroup {
            AddCityScreen()
                .environmentObject(Store())
        }
    }
}
