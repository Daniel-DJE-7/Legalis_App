//
//  CashPaymentModel.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 20/11/26.
//

import Foundation

struct CashPaymentRequest: Encodable {
    let appointment_id: Int
    let payment_method: String
}

struct CashPaymentResponse: Decodable {
    let id_payment: Int
    let appointment_id: Int
    let amount: Double
    let payment_status: String
}
