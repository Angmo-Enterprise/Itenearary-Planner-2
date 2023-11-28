// SearchView.swift
// App check
// Created by Jhala family on 7/11/23.

import SwiftUI
import MapKit
import UIKit

struct SearchView: View {

    @StateObject var locationManager: LocationManager = .init()
    @State var navigationTag: String?
    @Binding var itinerary: Itinerary
    
    @State private var showSheet = false
//    @Binding var address: CLPlacemark

    var body: some View {
        VStack {
            HStack() {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("Find locations here", text: $locationManager.searchText)
            }
            .padding(.vertical, 12)
            .padding(.horizontal)
            .background {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .strokeBorder(.gray)
            }
            .padding(.vertical, 10)

            if let places = locationManager.fetchedplaces, !places.isEmpty {
                List {
                    ForEach(places, id: \.self) { place in
                        Button {
                            if let coordinate = place.location?.coordinate {
                                locationManager.pickedLocation = .init(latitude: coordinate.latitude, longitude: coordinate.longitude)
                                locationManager.mapView.region = .init(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                                locationManager.addDraggeablePins(coordinate: coordinate)
                                locationManager.updatePlacemark(location: .init(latitude: coordinate.latitude, longitude: coordinate.longitude))
                            }
                            showSheet = true
                            navigationTag = "MAPVIEW"
                        } label: {
                            HStack {
                                Image(systemName: "mappin.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(.gray)

                                VStack(alignment: .leading, spacing: 6) {
                                    Text(place.name ?? "")
                                        .font(.title3.bold())
                                        .foregroundColor(.primary)
                                    Text((place.locality ?? place.subLocality) ?? "")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                }
                .listStyle(.plain)
            }
        }
        .padding()
        .frame(maxHeight: .infinity, alignment: .top)
//        .background {
//            NavigationLink(tag: "MAPVIEW", selection: $navigationTag) {
//                MapViewSelection(itinerary: $itinerary)
//                    .environmentObject(locationManager)
//                    .navigationBarHidden(true)
//            } label: {}
//            .labelsHidden()
//        }
        .sheet(isPresented: $showSheet){
            MapViewSelection(itinerary: $itinerary)
        }
        .environmentObject(locationManager)
    }
}


struct MapViewSelection: View {

//    @Binding var address: CLPlacemark
    @Binding var itinerary: Itinerary
    @EnvironmentObject var locationManager: LocationManager
    @Environment(\.dismiss) var dismiss
    
    // for places
    @State private var placeName = ""
    @State private var address = ""

    var body: some View {
        ZStack {
            MapViewHelper(locationManager: locationManager)
                .environmentObject(locationManager)
                .ignoresSafeArea()

            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title2.bold())
                    .foregroundColor(.primary)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)

            if let place = locationManager.pickedPlaceMark {
                VStack(spacing: 15) {
                    Text("Confirm Location")
                        .font(.title2.bold())

                    HStack {
                        Image(systemName: "mappin.circle.fill")
                            .font(.title2)
                            .foregroundColor(.gray)

                        VStack(alignment: .leading, spacing: 6) {
                            Text(place.name ?? "")
                                .font(.title3.bold())
                            Text((place.locality ?? place.subLocality) ?? "")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 10)

                    Button {
                        // this is where you create a Place
                        // you get a place that's a CLLocation -> convert it into a Place
                        // append it to the end of itinerary's places array
                        
                        placeName = place.name ?? ""
                        address = place.postalCode ?? ""
                        itinerary.places.append(Itinerary.Place(placename: placeName, address: address))
                        dismiss()
                        
                    } label: {
                        Text("Confirm Location")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.green)
                            }
                            .overlay(alignment: .trailing) {
                                Image(systemName: "arrow.right")
                                    .font(.title3.bold())
                                    .padding(.trailing)
                            }
                            .foregroundColor(.white)
                    }
                }
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.white)
                        .ignoresSafeArea()
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
        .onDisappear {
            locationManager.pickedLocation = nil
            locationManager.pickedPlaceMark = nil
            locationManager.mapView.removeAnnotations(locationManager.mapView.annotations)
        }
    }
}

struct MapViewHelper: UIViewRepresentable {

    @ObservedObject var locationManager: LocationManager

    func makeUIView(context: Context) -> MKMapView {
        return locationManager.mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        // Update your UIView
    }
}
