//
//  itineraryDetailsView.swift
//  final 2
//
//  Created by Jhala family on 21/11/23.
//

import SwiftUI

struct itineraryDetailsView: View {
    @State private var theManyPlaces: [Itinerary.places] = [Itinerary.places(placename: "Place", address: "Place", distance: 3489, traveltime: 3842, details: "this da detail", starttime: Date.now, timespent: 2376)]
    @Binding var itinerary: Itinerary
    @ObservedObject var itineraryManager: ItineraryManager
    @State var additemtransit = false
    
    var body: some View {
        VStack{
            DatePicker("Start:", selection: $itinerary.startdate)
            DatePicker("End:", selection: $itinerary.enddate)
            VStack {
                List(theManyPlaces){ places in
                    HStack(alignment: .top) { // Align items to the top
                        Image(systemName: "arrow")
                            .font(.system(size: 30)) // Adjust the icon size
                            .foregroundColor(.blue)
                            .padding()
                        
                        VStack(alignment: .leading) { // Align items to the leading edge
                            Text(places.placename)
                                .font(.headline)
                                .fontWeight(.bold)
                            
                            
                            Text("Distance: \(places.distance)m")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            
                            
                            // Add a humorous address
                            Text(places.address)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    .listRowSeparator(.hidden, edges: .bottom)
                }
                .toolbar{
                    EditButton()
                }
                .listStyle(.plain)
                
            }
            Spacer()
        }
        .padding()
        .navigationTitle(itinerary.country)
//        .navigationBarItems(trailing:
//                                NavigationLink(destination: addItemView(itineraryManager: itineraryManager)) {
//            Image(systemName: "Add Item")
//                .resizable()
//                .frame(width: 18, height: 18)
//        })
        .toolbar{
            ToolbarItem{
                Button{
                    addItemView(itinearary: $itinerary, itineraryManager: itineraryManager)
                }label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .none
    return formatter
}()

