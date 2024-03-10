//
//  UIColor+Extension.swift
//  digio
//
//  Created by André  Costa Dantas on 10/03/24.
//

import Foundation
import UIKit

extension UIColor {
    class var primaryColor: UIColor {
        return UIColor.init(named: "PrimaryColor")!
    }
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1.0)
    }
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
}
