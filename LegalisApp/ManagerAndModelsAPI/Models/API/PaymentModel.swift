//
//  PaymentModel.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 20/11/26.
//

import Foundation

struct PaymentCreateModel: Encodable {
    let appointmentId: Int
    let paymentMethod: String
}

struct PaymentResponseModel: Decodable {
    let idPayment: Int
    let appointmentId: Int
    let paymentMethod: String
    let amount: Double
    let paymentStatus: String
}
