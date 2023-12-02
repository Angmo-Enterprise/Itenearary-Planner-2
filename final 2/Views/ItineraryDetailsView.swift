import SwiftUI
import UniformTypeIdentifiers
import MapKit

struct ItineraryDetailsView: View {
    @Binding var itinerary: Itinerary
    @ObservedObject var itineraryManager: ItineraryManager
    @State var additemtransit = false
    
    @State private var showSheet = false
    
    var body: some View {
        VStack {
            List(1..<numberOfDays) { day in
                Section("Day \(day)") {
                    ForEach(itinerary.places.filter { $0.startDate > itinerary.startdate + (Double(day) * 60 * 60 * 24) }) { place in
                        // Your list content here
                        NavigationLink(destination: PlaceDetailView(place: placeBinding(place))) {
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
                                Spacer()
                                Text("\(place.startDate, formatter: dateFormatter)")
                            }
                        }
                    }
                }
            }

            Spacer()

            List {
                Section("Dates") {
                    DatePicker("Start:", selection: $itinerary.startdate)
                    DatePicker("End:", selection: $itinerary.enddate)
                }
                Section("More Info") {
                    PDFView()
                }
            }
            .listStyle(.sidebar)
            .padding()
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
        }
        .navigationTitle(itinerary.country)
    }

    private var numberOfDays: Int {
        Calendar.current.calculateDaysBetween(itinerary.startdate, and: itinerary.enddate)
    }

    private func placeBinding(_ place: Itinerary.Place) -> Binding<Itinerary.Place> {
        Binding(
            get: {
                place
            },
            set: { newValue in
                if let index = itinerary.places.firstIndex(where: { $0.id == newValue.id }) {
                    itinerary.places[index] = newValue
                }
            }
        )
    }
}

extension Calendar {
    func calculateDaysBetween(_ from: Date, and to: Date) -> Int {
        let fromDate = startOfDay(for: from)
        let toDate = startOfDay(for: to)
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate)
        return numberOfDays.day! + 1
    }
}

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .none
    return formatter
}()
