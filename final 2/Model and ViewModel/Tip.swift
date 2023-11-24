//
//  Tip.swift
//  final 2
//
//  Created by James Toh on 24/11/23.
//

import Foundation

import TipKit

struct AddIteneararyTip: Tip, Identifiable {
    var id = UUID()
    var title: Text {
        Text("Make a new itenearary!")
    }
    
    var message: Text? {
        Text("Tap here to create a new itenearary")
    }
    
    var image: Image? {
        Image(systemName: "list.bullet.below.rectangle")
    }
}
