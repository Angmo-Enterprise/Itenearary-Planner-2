//
//  itineraryDetailsView.swift
//  final 2
//
//  Created by Jhala family on 21/11/23.
//

import SwiftUI
import MapKit

struct ItineraryDetailsView: View {
    @Binding var itinerary: Itinerary
    @ObservedObject var itineraryManager: ItineraryManager
    @State var additemtransit = false
    
    @State private var showSheet = false
    
    var body: some View {
        VStack{
            VStack {
                List(itinerary.places.sorted {$0.startDate < $1.startDate}, id: \.id) { place in
                    NavigationLink{
                        PlaceDetailView(place: Binding(get: {
                            place
                        }, set: { newValue in
                            let index = itinerary.places.firstIndex {
                                $0.id == newValue.id
                            }!
                            
                            itinerary.places[index] = newValue
                        }))
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
                            Spacer()
                            Text("\(place.startDate, formatter: dateFormatter)")
                        }
                    }
                }
                Spacer()
                List{
                    Section("Dates"){
                        DatePicker("Start:", selection: $itinerary.startdate)
                        DatePicker("End:", selection: $itinerary.enddate)
                    }
                    Section("More Info"){
                        
                    }
                }
                .listStyle(.sidebar)
                .padding()
                .listStyle(.sidebar)
                
            }
            .navigationTitle(itinerary.country)
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
        }
        .navigationTitle(itinerary.country)

    }
}

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .none
    return formatter
}()

