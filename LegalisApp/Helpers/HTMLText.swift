//
//  HTMLText.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 8/6/26.
//

import UIKit


class HTMLText {
  
  //MARK: - method to convert my html into a String
  func setHTMLText(_ htmlString: String, fontFamily: String = "Inter-Regular", size: CGFloat = 12) -> NSAttributedString? {
  
    //convierte mi texto html en data binario "0010110",
    guard let data = htmlString.data(using: .utf8) else { return nil }
    //le decimos a swift como interpretar los datos, se dice: esto es texto html
    let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
      .documentType: NSAttributedString.DocumentType.html,
      .characterEncoding: String.Encoding.utf8.rawValue//el texto usa codigicacion utf8
    ]
 
    //toma el html y le aplica estilos
    if let baseAttributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) {
      
      let muttableAttributed = NSMutableAttributedString(attributedString: baseAttributedString)
      
      muttableAttributed.applyCustomFont(family: fontFamily, size: size)
      
      return muttableAttributed
    }
   return nil
  }
  
}
