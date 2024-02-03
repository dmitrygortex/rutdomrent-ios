//
//  BookingsModel.swift
//  RutApp
//
//  Created by Michael Kivo on 03/02/2024.
//

import Foundation

final class BookingsModel: Codable {
    
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

}
