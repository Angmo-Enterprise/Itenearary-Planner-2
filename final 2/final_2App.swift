//
//  final_2App.swift
//  final 2
//
//  Created by Jhala family on 20/11/23.
//

import SwiftUI
import TipKit

@main
struct final_2App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .task{
                    if #available(iOS 17.0, *) {
                        try? Tips.configure([
                            .displayFrequency(.immediate),
                            .datastoreLocation(.applicationDefault)])
                    } else {
                        // Fallback on earlier versions
                    }
                }
        }
    }
}
