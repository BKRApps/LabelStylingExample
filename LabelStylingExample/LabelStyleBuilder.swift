//
//  LabelStyleBuilder.swift
//  LabelStylingExample
//
//  Created by kumar reddy on 30/06/19.
//  Copyright © 2019 kumar reddy. All rights reserved.
//

import Foundation
import UIKit

public final class LabelStyleBuilder {
    private let inputText: String
    private weak var label: UILabel?
    private var attributes = [NSAttributedString.Key: Any]()
    private var lineHeight: CGFloat?
    private var attributedText: NSMutableAttributedString!
    
    public init(inputText: String, label: UILabel) {
        self.inputText = inputText
        self.label = label
        self.attributedText = NSMutableAttributedString(string: inputText)
    }
    
    private func getRanges(texts: [String]?) -> [NSRange] {
        guard let texts = texts else {
            return [NSRange(location: 0, length: attributedText.length)]
        }
        var ranges = [NSRange]()
        for text in texts {
            if let range = inputText.range(of: text) {
                let nsRange = NSRange(range, in: inputText)
                ranges.append(nsRange)
            }
        }
        return ranges
    }
    
    public func set(font: UIFont, for texts: [String]? = nil) -> LabelStyleBuilder {
        _ = getRanges(texts: texts).map { attributedText.addAttributes([NSAttributedString.Key.font: font], range: $0)}
        return self
    }
    
    public func set(font: UIFont, forgroundColor: UIColor, for texts: [String]? = nil) -> LabelStyleBuilder {
        _ = getRanges(texts: texts).map { attributedText.addAttributes([NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: forgroundColor], range: $0)}
        return self
    }
    
    public func set(attributes: [NSAttributedString.Key: Any], for texts: [String]?) -> LabelStyleBuilder {
        _ = getRanges(texts: texts).map { attributedText.addAttributes(attributes, range: $0)}
        return self
    }
    
    
    public func set(lineHeight: CGFloat = 1,
                    spacing: CGFloat = 0) -> LabelStyleBuilder {
        self.lineHeight = lineHeight
        attributes[NSAttributedString.Key.kern] = spacing
        return self
    }
    
    public func build() {
        let parahraphStyle = NSMutableParagraphStyle.init()
        parahraphStyle.lineHeightMultiple = self.lineHeight ?? 1.0
        parahraphStyle.lineBreakMode = self.label?.lineBreakMode ?? NSLineBreakMode.byTruncatingTail
        parahraphStyle.alignment = self.label?.textAlignment ?? NSTextAlignment.left
        attributes[NSAttributedString.Key.paragraphStyle] = parahraphStyle
        attributedText.addAttributes(attributes, range: NSRange(location: 0, length: attributedText.length))
        self.label?.attributedText = attributedText
    }
}

