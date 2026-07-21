//
//  MyAccountStyle.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 17/7/26.
//

import UIKit

enum SectionMyAccount: Int, CaseIterable {
  case profilePhoto
  case personalConfiguation
  case settings
  case logout
}

  var titleHeaderMenu = ["INFORMACIÓN PERSONAL", "CONFIGURACIÓN"]

  let logout = CategoriesModel(
  leftIcon: UIImage(named: "logoutRed"),
  name: "Cerrar Sesión"
  )

  let person = [
  CategoriesModel(leftIcon: UIImage(named: "personCircleBlue"), name: "Mi cuenta"),
  CategoriesModel(leftIcon: UIImage(named: "infoBlue"), name: "Acerca de")
  ]

  let settings = [
  CategoriesModel(leftIcon: UIImage(named: "bellBlue"), name: "Notificaciones"),
  CategoriesModel(leftIcon: UIImage(named: "helpBlue"), name: "Ayuda"),
  CategoriesModel(leftIcon: UIImage(named: "shieldBlue"), name: "Seguridad"),
  CategoriesModel(leftIcon: UIImage(named: "worldBlue"), name: "idioma")
  ]

