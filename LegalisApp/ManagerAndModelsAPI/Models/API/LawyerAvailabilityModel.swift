//
//  LawyerAvailabilityModel.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 20/11/26.
//

import Foundation

struct LawyerAvailabilityModel: Decodable {
    let idLawyer: Int
    let date: String
    let isHoliday: Bool
    let holidayName: String?
    let availableSlots: [LawyerAvailableSlotModel]
}

struct LawyerAvailableSlotModel: Decodable {
    let startTime: Date
    let endTime: Date
}
