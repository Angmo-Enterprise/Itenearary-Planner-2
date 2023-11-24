//
//  itineraryDetailsView.swift
//  final 2
//
//  Created by Jhala family on 21/11/23.
//

import SwiftUI

struct itineraryDetailsView: View {
    @Binding var itinerary: Itinerary
    @ObservedObject var itineraryManager: ItineraryManager
    @State var additemtransit = false
    
    var body: some View {
        VStack{
            DatePicker("Start:", selection: $itinerary.startdate)
            DatePicker("End:", selection: $itinerary.enddate)
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
                    addItemView(itineraryManager: itineraryManager)
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

