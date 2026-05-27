//
//  RegisterModel.swift
//  LegalisApp
//
//  Created by Memo Figueredo on 9/5/26.
//

import UIKit

enum Sex {
  case male
  case female
}

enum PracticeType {
  case none
  case independent
  case employee
}

//personalInformationModel for the UI
struct RegisterModel {
  let leftImage: UIImage?
  let placeholder: String
  let rightImage: UIImage?
}

//Register model to extract the information of textFields
struct ExtractingCredentialsModel {
  let name: String
  let numberOfDocument: Int64
  let mobileNumber: Int64
  let email: String
  let password: String
  let sex: Sex?
  let practiceType: PracticeType?
}
