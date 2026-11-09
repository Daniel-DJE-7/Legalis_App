//
//  UserModel.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 9/11/26.
//

import Foundation

struct UserModel: Codable {
  
  let id: Int
  let name: String
  let email: String
  let identityCard: String
  let phoneNumber: String
  let sex: String?
  let accountType: String
  let isActive: Bool
  
}
