//
//  TemporaryItineararyView.swift
//  final 2
//
//  Created by James Toh on 30/11/23.
//

import SwiftUI
import MapKit

struct TemporaryItineraryDetailsView: View {
    @Binding var itinerary: Itinerary
    @ObservedObject var itineraryManager: ItineraryManager
    @State private var additemtransit = false
    @State private var showSheet = false
    
    var body: some View {
        VStack {
            VStack {
                List($itinerary.places, id: \.id) { $place in
                    NavigationLink(destination: PlaceDetailView(place: $place)) {
                        HStack(alignment: .top) {
                            Image(systemName: "paperplane.circle.fill")
                                .font(.system(size: 30))
                                .foregroundColor(.blue)
                            
                            VStack(alignment: .leading) {
                                Text(place.placename)
                                    .font(.headline)
                                    .fontWeight(.bold)
                                
                                Text(place.address)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
                Spacer()
                Group {
                    DatePicker("Start:", selection: $itinerary.startdate)
                    DatePicker("End:", selection: $itinerary.enddate)
                }
                .padding()
                .navigationTitle(itinerary.country)
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        showSheet = true
                    } label: {
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
