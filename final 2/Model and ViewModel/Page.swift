//
//  Page.swift
//  final 2
//
//  Created by James Toh on 24/11/23.
//

import Foundation

struct Page: Identifiable, Codable {
    var id = UUID()
    
    var title: String
    var description: String
    var imageIndex: Int
}

