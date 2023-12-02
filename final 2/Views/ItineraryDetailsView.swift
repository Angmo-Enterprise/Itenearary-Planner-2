import SwiftUI
//import UniformTypeIdentifiers
import MapKit

struct ItineraryDetailsView: View {
    @Binding var itinerary: Itinerary
    @ObservedObject var itineraryManager: ItineraryManager
    @State var additemtransit = false
   
    
    @State private var showSheet = false
    
    var body: some View {
        VStack {
            List(1..<numberOfDays, id: \.self) { day in
                Section("Day \(day)") {
                    ForEach(itinerary.places.filter { doesItineraryFallOnDate(date: dateFromDayNumber(day), place: $0) }) { place in
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
                    .onMove { indices, newOffset in
                        print("Moving from indices: \(indices), to new offset: \(newOffset)")
                        itinerary.places.move(fromOffsets: indices, toOffset: newOffset)
                    }
                }
                
            }
           

            Spacer()

            
                
            
            List {
                Section("Dates") {
                    DatePicker("Start:", selection: $itinerary.startdate)
                    DatePicker("End:", selection: $itinerary.enddate)
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
        .onAppear {
            print(itinerary.places)
        }
        .navigationTitle(itinerary.country)
        .navigationBarItems(trailing: EditButton())
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
    
    private func dateFromDayNumber(_ dayNumber: Int) -> Date {
        print("day \(dayNumber)")
        return itinerary.startdate.advanced(by: TimeInterval((dayNumber - 1) * 24 * 60 * 60))
    }
    
    private func doesItineraryFallOnDate(date: Date, place: Itinerary.Place) -> Bool {
        var dateComponents = Calendar.current.dateComponents([.day,.month,.year], from: date)
        let day = dateComponents.day!
        let month = dateComponents.month!
        let year = dateComponents.year!
        
        let midnightOfDay = DateComponents(year:year, month: month, day: day, hour: 0, minute: 0, second: 0)
        let lastSecondOfDay = DateComponents(year:year, month: month, day: day, hour: 23, minute: 59, second: 59)
        
        
        let midnight = Calendar.current.date(from: midnightOfDay) ?? Date()
        let lastSecond = Calendar.current.date(from: lastSecondOfDay) ?? Date()
        
        let test = (midnight...lastSecond).contains(place.startDate)
        if test {
            print("Date \(place.startDate)")
            return test
        } else {
            return false
        }
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
