//
//  itineraryDetailsView.swift
//  final 2
//
//  Created by Jhala family on 21/11/23.
//

import SwiftUI
import MapKit

struct itineraryDetailsView: View {
    @Binding var itinerary: Itinerary
    @ObservedObject var itineraryManager: ItineraryManager
    @State var additemtransit = false
    
    @State private var showSheet = false
    
    var body: some View {
        VStack{
            VStack {
                List($itinerary.places, id: \.id) { $place in
                    NavigationLink{
                        PlaceDetailView(place: $place)
                    } label: {
                        HStack(alignment: .top) { // Align items to the top
                            Image(systemName: "paperplane.circle.fill")
                                .font(.system(size: 30)) // Adjust the icon size
                                .foregroundColor(.blue)
                            
                            VStack(alignment: .leading) { // Align items to the leading edge
                                Text(place.placename)
                                    .font(.headline)
                                    .fontWeight(.bold)
                                
                                // Add a humorous address
                                Text(place.address)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
                Spacer()
                Group{
                    DatePicker("Start:", selection: $itinerary.startdate)
                    DatePicker("End:", selection: $itinerary.enddate)
                }
                .padding()
                .navigationTitle(itinerary.country)
                
            }
            .toolbar{
                ToolbarItem{
                    Button{
                        showSheet = true
                    }label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showSheet) {
                SearchView(itinerary: $itinerary)
            }
            
            Text("Thing")
        }
    }
}

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .none
    return formatter
}()

