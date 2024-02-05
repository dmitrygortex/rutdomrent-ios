//
//  BookingsModel.swift
//  RutApp
//
//  Created by Michael Kivo on 03/02/2024.
//

import Foundation

final class BookingsModel: Codable, Equatable {
    
    var date: String?
    var time: String?
    var purpose: String?
    var room: String?
    var uid: String?
    
    init(date: String, time: String, purpose: String, room: String, uid: String) {
        self.date = date
        self.time = time
        self.purpose = purpose
        self.room = room
        self.uid = uid
    }
    
    static func == (lhs: BookingsModel, rhs: BookingsModel) -> Bool {
        return lhs.room == rhs.room && lhs.date == rhs.date && lhs.time == rhs.time && lhs.purpose == rhs.purpose && lhs.uid == rhs.uid
    }

}
