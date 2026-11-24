//
//  LawyerScheduleModel.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 23/11/26.
//

import Foundation

//modelo que representa los horarios semanales por el abogado
struct LawyerScheduleModel: Decodable {
    let idSchedule: Int
    let weekday: Int
    let startTime: String
    let endTime: String
    let isActive: Bool
    let idLawyer: Int
}
