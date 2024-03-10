//
//  CustomLabel.swift
//  digio
//
//  Created by André  Costa Dantas on 10/03/24.
//

import UIKit

class CustomLabel: UILabel {

    var firstPart: (text: String, color: UIColor)?
    var secondPart: (text: String, color: UIColor)?

    func setParts(first: (text: String, color: UIColor), second: (text: String, color: UIColor)) {
        self.firstPart = first
        self.secondPart = second
        updateText()
    }

    private func updateText() {
        guard let firstPart = firstPart, let secondPart = secondPart else {
            self.text = nil
            return
        }

        let font = UIFont.boldSystemFont(ofSize: 18)
        let firstAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: firstPart.color, .font: font]
        let secondAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: secondPart.color, .font: font]

        let firstAttributedString = NSMutableAttributedString(string: firstPart.text, attributes: firstAttributes)
        let secondAttributedString = NSAttributedString(string: secondPart.text, attributes: secondAttributes)

        firstAttributedString.append(secondAttributedString)

        self.attributedText = firstAttributedString
    }
}
