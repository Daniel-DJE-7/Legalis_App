//
//  AppointmentAPIModel.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 24/11/26.
//

import Foundation

// MARK: - Datos enviados para crear una cita
struct AppointmentCreateModel: Encodable {

    let startTime: Date
    let durationHours: Int
    let modality: String
    let idLawyer: Int
    let idClient: Int

}

// MARK: - Datos recibidos al crear una cita
struct AppointmentResponseModel: Decodable {

    let idAppointment: Int
    let startTime: Date
    let finalHour: Date
    let durationHours: Int
    let price: Int
    let bookedHourlyRate: Int
    let modality: String
    let appointmentStatus: String
    let urlConference: String?
    let idLawyer: Int
    let idClient: Int

}
