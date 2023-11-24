//
//  TodoManager.swift
//  final 2
//
//  Created by Jhala family on 20/11/23.
//

import Foundation
import SwiftUI

class ItineraryManager: ObservableObject {
    @Published var itinerarys: [Itinerary] = []{
        didSet {
            save()
        }
    }
    init() {
        load()
    }
    func getArchiveURL() -> URL {
        let plistName = "itinerarys.plist"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        return documentsDirectory.appendingPathComponent(plistName)
    }
    func save() {
        let archiveURL = getArchiveURL()
        let propertyListEncoder = PropertyListEncoder()
        let encodedItinerarys = try? propertyListEncoder.encode(itinerarys)
        try? encodedItinerarys?.write(to: archiveURL, options: .noFileProtection)
    }
    func load() {
        let archiveURL = getArchiveURL()
        print(archiveURL)
        let propertyListDecoder = PropertyListDecoder()
                
        if let retrievedItineraryData = try? Data(contentsOf: archiveURL),
            let itinerarysDecoded = try? propertyListDecoder.decode([Itinerary].self, from: retrievedItineraryData) {
            itinerarys = itinerarysDecoded
        }
    }
}
