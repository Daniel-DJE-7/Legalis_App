//
//  RegisterModel.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 9/5/26.
//

import UIKit

//personalInformationModel for the UI
struct RegisterModel {
  let leftImage: UIImage?
  let placeholder: String
  let rightImage: UIImage?
}

enum Sex {
  case male
  case female
}

enum PracticeType {
  case none
  case independent
  case employee
}

//Register model to extract the information of textFields
struct ExtractingCredentialsModel {
  let name: String
  let numberOfDocument: String
  let mobileNumber: String
  let email: String
  let password: String
  let sex: Sex?
  let practiceType: PracticeType?
}
