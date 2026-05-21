//
//  NSMutableAttributedString.swift
//  LegalisApp
//
//  Created by Memo Figueredo on 20/5/26.
//

import UIKit

extension NSMutableAttributedString {
  
  func applyCustomFont(family: String, size: CGFloat) {
    let regularFontName = family
    let italicFontName = "\(family)-Italic"
    let boldFontName = "\(family)-Bold"
    
    self.enumerateAttribute(.font, in: NSRange(location: 0, length: self.length), options: []) { (value, range, stop) in
      
      if let currentFont = value as? UIFont {
        var customFont: UIFont
        
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
        
        self.addAttribute(.font, value: customFont, range: range)
      }
    }
  }
}
