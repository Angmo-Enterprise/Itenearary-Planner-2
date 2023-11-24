//
//  ContentView.swift
//  final 2
//
//  Created by Jhala family on 20/11/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var itineraryManager = ItineraryManager()
    @State private var showSheet = false
    
    var body: some View {
        TabView{
            HomeView(itineraryManager: itineraryManager)
                .tabItem{
                    Label("Home", systemImage: "house.fill")
                }
            itineraryView(itineraryManager: itineraryManager)
                .tabItem{
                    Label("Itineraries", systemImage: "list.clipboard.fill")
                }
        }
        .onAppear{
            showSheet = true
        }
        .sheet(isPresented: $showSheet, content: {
            IntroPageView()
        })
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
