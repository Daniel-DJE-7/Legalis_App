//
//  LawyerCards.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 18/6/26.
//

import UIKit

struct LawyersCardsModel {
  let profileImage: UIImage?
  let name: String
  var qualification: String?
}

struct LawyersPersonalProfile {
  let card: LawyersCardsModel?
  let description: String
  let email: String
  let price: String
}
