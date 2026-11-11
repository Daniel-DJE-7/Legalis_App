//
//  UserRegistrationModel.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 10/11/26.
//

import Foundation

struct UserRegistrationModel: Encodable {
  
  let name: String
  let email: String
  let password: String
  let identityCard: String
  let phoneNumber: String
  let sex: String?
  let accountType: String
  
}
