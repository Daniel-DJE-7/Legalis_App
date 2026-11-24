//
//  LawyerResponseModel.swift
//  LegalisApp
//
//  Created by Memo Figueredo on 23/11/26.
//

import Foundation

import Foundation

// MARK: - Respuesta del abogado desde FastAPI
struct LawyerResponseModel: Decodable {

    let idLawyer: Int
    let schooling: String?
    let typeExcersise: String?
    let company: String?
    let hourlyRate: Int?
    let user: LawyerUserResponseModel

}

// MARK: - Información del usuario asociado al abogado
struct LawyerUserResponseModel: Decodable {

    let id: Int
    let name: String
    let email: String
    let identityCard: String
    let phoneNumber: String
    let sex: String?
    let accountType: String
    let isActive: Bool

}
