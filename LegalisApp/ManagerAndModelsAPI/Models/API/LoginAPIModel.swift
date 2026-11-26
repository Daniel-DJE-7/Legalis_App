//
//  LoginAPIModel.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 25/11/26.
//

import Foundation

struct LoginRequestModel: Encodable {
    let email: String
    let password: String
}

struct AuthenticatedProfileModel: Decodable {
    let accessToken: String
    let tokenType: String
    let user: UserModel
}

struct LoginResponseModel: Decodable {
    let requiresProfileSelection: Bool
    let profiles: [AuthenticatedProfileModel]
}
