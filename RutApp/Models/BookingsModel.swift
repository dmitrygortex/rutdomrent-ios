//
//  BookingsModel.swift
//  RutApp
//
//  Created by Michael Kivo on 03/02/2024.
//

import Foundation

final class BookingsModel {
    var date: String?
    var time: String?
    var purpose: String?
    var room: String?
    
    init(date: String? = nil, time: String? = nil, purpose: String? = nil, room: String? = nil) {
        self.date = date
        self.time = time
        self.purpose = purpose
        self.room = room
    }
}
