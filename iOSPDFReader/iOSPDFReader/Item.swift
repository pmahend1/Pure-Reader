//
//  Item.swift
//  iOSPDFReader
//
//  Created by Prateek Mahendrakar on 1/25/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
