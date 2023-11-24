//
//  addItemView.swift
//  final 2
//
//  Created by Jhala family on 21/11/23.
//

import SwiftUI

struct addItemView: View {
    @ObservedObject var itineraryManager: ItineraryManager
    @State private var searchView = false
    var body: some View {
        NavigationStack{
            Text("New Place")
                .font(.largeTitle)
            VStack{
                HStack{
                    Text("location")
                    NavigationLink("Search for the place name"){
                        SearchView(itineararyManager: itineraryManager)
                        
                    }
                }
            }
        }.navigationTitle("Add an item")
    }
}

struct addItemView_Previews: PreviewProvider {
    static var previews: some View {
        addItemView(itineraryManager: ItineraryManager())
    }
}
