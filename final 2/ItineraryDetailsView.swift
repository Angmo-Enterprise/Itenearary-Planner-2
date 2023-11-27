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
                List(itinerary.places){ places in
                    HStack(alignment: .top) { // Align items to the top
                        Image(systemName: "paperplane.circle.fill")
                            .font(.system(size: 30)) // Adjust the icon size
                            .foregroundColor(.blue)
                            .padding()
                        
                        VStack(alignment: .leading) { // Align items to the leading edge
                            Text(places.placename)
                                .font(.headline)
                                .fontWeight(.bold)
                            
                            // Add a humorous address
                            Text(places.address)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                }
                .toolbar{
                    EditButton()
                }
                .listStyle(.plain)
                
            }
            Spacer()
            DatePicker("Start:", selection: $itinerary.startdate)
                .padding()
            DatePicker("End:", selection: $itinerary.enddate)
                .padding()
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
                    showSheet = true
                }label: {
                    Image(systemName: "plus")
                }
            }
        }
        .fullScreenCover(isPresented: $showSheet) {
            SearchView(itinerary: $itinerary)

        }
    }
}

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .none
    return formatter
}()

