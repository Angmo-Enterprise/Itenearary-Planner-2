//
//  Itinerarydetailview.swift
//  final 2
//
//  Created by Jhala family on 20/11/23.
//

import SwiftUI
import MapKit

struct itineraryView: View {
    @State private var addview = false
    @ObservedObject var itineraryManager: ItineraryManager
    
    var body: some View {
        NavigationStack {
                List($itineraryManager.itinerarys, editActions: .all) { $itinerary in
                    
                     let url = itinerary

                    
                    NavigationLink(destination: ItineraryDetailsView(itinerary: $itinerary, itineraryManager: itineraryManager)) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(itinerary.country)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                    .fontWeight(.bold)
                                
                                HStack {
                                    Image(systemName: "calendar")
                                        .foregroundColor(.blue)
                                        .fontWeight(.semibold)
                                    Text("\(itinerary.startdate, formatter: dateFormatter) - \(itinerary.enddate, formatter: dateFormatter)")
                                        .foregroundColor(.secondary)
                                        .fontWeight(.semibold)
                                }
                                
                                HStack {
                                    Image(systemName: "clock")
                                        .foregroundColor(.green)
                                        .fontWeight(.semibold)
                                    if calculateDays(from: itinerary.startdate) > 0{
                                        Text("In ")
                                            .foregroundColor(.secondary)
                                            .fontWeight(.semibold)
                                        Text("\(calculateDays(from: itinerary.startdate))")
                                            .foregroundColor(.secondary)
                                            .fontWeight(.semibold)
                                        Text("days")
                                            .foregroundColor(.secondary)
                                            .fontWeight(.semibold)
                                    } else{
                                        Text("Started")
                                            .foregroundColor(.secondary)
                                            .fontWeight(.semibold)
                                        Text("\(abs(calculateDays(from: itinerary.startdate)))")
                                            .foregroundColor(.secondary)
                                            .fontWeight(.semibold)
                                        Text("days")
                                            .foregroundColor(.secondary)
                                            .fontWeight(.semibold)
                                        Text("ago")
                                            .foregroundColor(.secondary)
                                            .fontWeight(.semibold)
                                        
                                        
                                    }
                                }
                            }
                            .padding(.vertical, 8)
                        }
                        .contextMenu(ContextMenu(menuItems: {
                            Text("jeje")
                        }))
                        .listRowBackground(Color.white)
                }
            .navigationTitle("Itineraries")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing){
                    Button {
                        addview = true
                    } label: {
                        Label("Add todo", systemImage: "plus")
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $addview){
                AddItineraryView(itineraries: $itineraryManager.itinerarys)
            }
        }
    }
    
    func calculateDays(from startDate: Date) -> Int {
        let currentDate = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: currentDate, to: startDate)
        return (components.day ?? 0) + 1
    }
}

