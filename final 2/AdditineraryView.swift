import SwiftUI

struct AddItineraryView: View {
    
    @Binding var itineraries: [Itinerary]
    @State private var countryname = ""
    var alignToControl: Bool = false
    @State var daysdefault = 0
    @State var totalcostdefault = 1000
    @State var startdatedefault = Date()
    @State var enddatedefault = Date()
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            Text("New Itenearary")
                .bold()
                .padding()
            Form {
                Section("General Info") {
                    VStack{
                        TextField("Enter a title (Example: Trip to India)", text: $countryname)
                    }
                }
                Section("Budget"){
                    HStack {
                        Text("Total budget:")
                        TextField("Enter budget", value: $totalcostdefault, formatter: NumberFormatter())
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(minWidth: 15, maxWidth: 60)
                            .alignmentGuide(.controlAlignment) { $0[.leading] }
                            .keyboardType(UIKeyboardType.numberPad)
                        Stepper("Enter budget", value: $totalcostdefault, in: 1...1000000000000000000)
                            .labelsHidden()
                    }
                    .alignmentGuide(.leading) {
                        self.alignToControl
                            ? $0[.controlAlignment]
                            : $0[.leading]
                    }
                }
                Section("Dates"){
                    VStack{
                        DatePicker("Start:", selection: $startdatedefault)
                        DatePicker("End:", selection: $enddatedefault)
                            .onChange(of: [startdatedefault, enddatedefault]) { _ in
                                updateNumberOfDays()
                            }
                        HStack {
                            Text("Number of days")
                            TextField("Enter days", value: $daysdefault, formatter: NumberFormatter())
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(minWidth: 15, maxWidth: 60)
                                .alignmentGuide(.controlAlignment) { $0[.leading]}
                                .disabled(true)
                            Spacer()
                        }
                        .alignmentGuide(.leading) {
                            self.alignToControl
                                ? $0[.controlAlignment]
                                : $0[.leading]
                        }
                    }
                }
                Section {
                    Button("Save", role: .none) {
                        let newitinerary = Itinerary(country: countryname, startdate: startdatedefault, iscompleted: false, enddate: enddatedefault, days: daysdefault, totalcost: totalcostdefault, places: [])
                        print("hello world")
                        print(newitinerary)
                        itineraries.append(newitinerary)
                        dismiss()
                    }
                    Button("Cancel", role: .destructive) {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func updateNumberOfDays() {
        let numberOfDays = Calendar.current.numberOfDaysBetween(startdatedefault, and: enddatedefault)
        daysdefault = numberOfDays
    }
}

extension HorizontalAlignment {
    private enum ControlAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            return context[HorizontalAlignment.center]
        }
    }
    static let controlAlignment = HorizontalAlignment(ControlAlignment.self)
}


extension Calendar {
    func numberOfDaysBetween(_ from: Date, and to: Date) -> Int {
        let fromDate = startOfDay(for: from)
        let toDate = startOfDay(for: to)
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate)
        
        return numberOfDays.day! + 1 // <1>
    }
}
