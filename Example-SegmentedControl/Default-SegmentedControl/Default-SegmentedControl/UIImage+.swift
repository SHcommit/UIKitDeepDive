//
//  UIImage+.swift
//  Default-SegmentedControl
//
//  Created by 양승현 on 10/30/23.
//

import UIKit

extension UIImage {
  func addText(_ text: String, isImageBeforeText: Bool, font: UIFont? = nil) -> UIImage {
    let offset: CGFloat = 7
    let font = font ?? UIFont.systemFont(ofSize: 15)
    let textSize = text.size(withAttributes: [.font: font])
    let width = size.width + offset + textSize.width
    let height = max(size.height, textSize.height)
    
    let format = UIGraphicsImageRendererFormat()
    format.opaque = false
    
    let render = UIGraphicsImageRenderer(size: .init(width: width, height: height), format: format)
    
    return render.image { context in
      let textOriginY: CGFloat = (height - textSize.height) / 2
      let textOriginX: CGFloat = isImageBeforeText ? size.width + offset : 0
      let textPoint: CGPoint = .init(x: textOriginX, y: textOriginY)
      (text as NSString).draw(at: textPoint, withAttributes: [.font: font])
      
      let alignment: CGFloat = isImageBeforeText ? 0 : textSize.width + offset
      let rect = CGRect(x: alignment, y: (height - size.height)/2 , width: size.width, height: size.height)
      draw(in: rect)
    }
  }
}
