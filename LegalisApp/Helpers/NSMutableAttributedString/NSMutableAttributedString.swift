//
//  NSMutableAttributedString.swift
//  LegalisApp
//
//  Created by Memo Figueredo on 20/5/26.
//

import UIKit

extension NSMutableAttributedString {
  
  func applyCustomFont(family: String, size: CGFloat) {
    //guarda el nombre de la fuente normal
    let regularFontName = "\(family)-Regular"
    let italicFontName = "\(family)-Italic"
    let boldFontName = "\(family)-Bold"
    
    //recorre todo el texto
    self.enumerateAttribute(.font, in: NSRange(
      location: 0,
      length: self.length), options: []) { (value, range, stop) in
      //value: la fuente actual
      //range: parte del texto donde está la fuente
      //stop: detiene el recorrido si se quiere
      if let currentFont = value as? UIFont {
        var customFont: UIFont
        
        //if fount in my text is html
        if currentFont.fontDescriptor.symbolicTraits.contains(.traitBold) {
          // Si era negrita en el HTML, le ponemos tu fuente Bold
          customFont = UIFont(name: boldFontName, size: size) ?? UIFont.boldSystemFont(ofSize: size)
        } else if currentFont.fontDescriptor.symbolicTraits.contains(.traitItalic) {
          // Si era cursiva, le ponemos tu fuente Italic
          customFont = UIFont(name: italicFontName, size: size) ?? UIFont.italicSystemFont(ofSize: size)
        } else {
          // Si es texto normal, le ponemos tu fuente Regular
          customFont = UIFont(name: regularFontName, size: size) ?? UIFont.systemFont(ofSize: size)
        }
        
        //we change the normal font and apply new personalize font
        self.addAttribute(.font, value: customFont, range: range)
      }
    }
  }
}
