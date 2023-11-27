//
//  addItemView.swift
//  final 2
//
//  Created by Jhala family on 21/11/23.
//

import SwiftUI

struct addItemView: View {
    
    @Binding var itinearary: Itinerary
    @ObservedObject var itineraryManager: ItineraryManager
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    Spacer()
                    Button{
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .padding()
                    }
                }

                Spacer()
                Text("New Place")
                    .font(.largeTitle)
                
                HStack{
                    Text("location")
                    NavigationLink("Search for the place name"){
                        SearchView(itineararyManager: itineraryManager)
                        
                    }
                }
                Spacer()
            }
        }
        .navigationTitle("Add an item")
        
    }
}


