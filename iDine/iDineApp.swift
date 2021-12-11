//
//  iDineApp.swift
//  iDine
//
//  Created by Srinivas Sahu on 16/11/21.
//

import SwiftUI

@main
struct iDineApp: App {
    @StateObject var order = Order()
    var body: some Scene {
        WindowGroup {
            MainView ()
                .environmentObject(order)
        }
    }
}
