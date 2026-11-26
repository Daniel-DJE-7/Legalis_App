//
//  LawyerScheduleModel.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 23/11/26.
//

import Foundation

// MARK: - Horarios semanales registrados por el abogado
struct LawyerScheduleModel: Decodable {

    let idSchedule: Int
    let weekday: Int
    let idLawyer: Int
    let hours: [String]

}
