//
//  PlaceDetailView.swift
//  final 2
//
//  Created by James Toh on 29/11/23.
//

import SwiftUI

struct PlaceDetailView: View {
    
    @Binding var place: Itinerary.Place
    
    var body: some View {
        VStack{
            DatePicker("Start date", selection: $place.startDate)
            DatePicker("End date", selection: $place.endDate)
        }
    }
}

