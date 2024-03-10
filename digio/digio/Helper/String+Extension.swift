//
//  String+Extension.swift
//  digio
//
//  Created by André  Costa Dantas on 09/03/24.
//

import Foundation
import UIKit

extension String {

    // MARK: - Localized Strings
    func localization() -> String {
        return NSLocalizedString(self, comment: "")
    }

    func localization(values: CVarArg) -> String {
        return String.localizedStringWithFormat(self.localization(), values)
    }

    func localization(values: CVarArg...) -> String {
        return String(format: self.localization(), locale: Locale.current, arguments: values)
    }

    // MARK: - URL Button
    func attributedStringWithLinks() -> NSAttributedString {
           let attributedString = NSMutableAttributedString(string: self)
           let types: NSTextCheckingResult.CheckingType = [.link]

           let detector = try? NSDataDetector(types: types.rawValue)
           let range = NSRange(startIndex..., in: self)
           detector?.enumerateMatches(in: self, options: [], range: range) { (match, _, _) in
               if let match = match {
                   attributedString.addAttributes([.link: match.url as Any,
                                                   .foregroundColor: UIColor.blue], range: match.range)
               }
           }
           return attributedString
       }
    
}
