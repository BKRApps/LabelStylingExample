//
//  ViewController.swift
//  LabelStylingExample
//
//  Created by kumar reddy on 30/06/19.
//  Copyright © 2019 kumar reddy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    let sampleText = "This is a about styling the label using the builder pattern, so we can be more productive and easy way to style the label. No more boilerplate code"

    override func viewDidLoad() {
        super.viewDidLoad()
        styleLabelUsingBuilder()
        styleUsingBoilerplateCode()
    }
    
    func styleLabelUsingBuilder() {
        LabelStyleBuilder(inputText: sampleText, label: label1)
            .set(font: UIFont.systemFont(ofSize: 16))
            .set(font: UIFont.boldSystemFont(ofSize: 18), forgroundColor: UIColor.red, for: ["builder"])
            .set(font: UIFont.boldSystemFont(ofSize: 18), forgroundColor: UIColor.blue, for: ["productive", "easy"])
            .set(attributes: [NSAttributedString.Key.strikethroughStyle : NSUnderlineStyle.thick.rawValue], for: ["No more boilerplate code"])
            .set(lineHeight: 1.2, spacing: 1.2)
            .build()
    }
    
    func styleUsingBoilerplateCode() {
        label2.font = UIFont.systemFont(ofSize: 16)
        let attributedText = NSMutableAttributedString(string: sampleText)
        if let range = sampleText.range(of: "builder") {
            let nsRange = NSRange(range, in: sampleText)
            attributedText.addAttributes([
                .foregroundColor: UIColor.red,
                .font: UIFont.boldSystemFont(ofSize: 18)
                ], range: nsRange)
        }
        if let range = sampleText.range(of: "productive") {
            let nsRange = NSRange(range, in: sampleText)
            attributedText.addAttributes([
                .foregroundColor: UIColor.blue,
                .font: UIFont.boldSystemFont(ofSize: 18)
                ], range: nsRange)
        }
        if let range = sampleText.range(of: "easy") {
            let nsRange = NSRange(range, in: sampleText)
            attributedText.addAttributes([
                .foregroundColor: UIColor.blue,
                .font: UIFont.boldSystemFont(ofSize: 18)
                ], range: nsRange)
        }
        if let range = sampleText.range(of: "No more boilerplate code") {
            let nsRange = NSRange(range, in: sampleText)
            attributedText.addAttributes([
                NSAttributedString.Key.strikethroughStyle : NSUnderlineStyle.thick.rawValue
                ], range: nsRange)
        }
        let parahraphStyle = NSMutableParagraphStyle.init()
        parahraphStyle.lineHeightMultiple = 1.2
        parahraphStyle.lineBreakMode = label2.lineBreakMode
        parahraphStyle.alignment = label2.textAlignment
        attributedText.addAttributes([NSAttributedString.Key.paragraphStyle: parahraphStyle, NSAttributedString.Key.kern: 1.2], range: NSRange(location: 0, length: attributedText.length))
        label2.attributedText = attributedText
    }

}

