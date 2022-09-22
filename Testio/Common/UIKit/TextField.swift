//
//  TextField.swift
//  Testio
//
//  Created by Timur Asayonok on 20/09/2022.
//

import Foundation
import UIKit

// MARK: TextField
// Custom TextField with custom styles
class TextField: UITextField {
    var cornerRadius: CGFloat = 10
    var horizontalInset: CGFloat = 10
    
    override var placeholder: String? {
        didSet {
            attributedPlaceholder = NSAttributedString(
                string: placeholder ?? "",
                attributes: [
                    .foregroundColor: UIColor.gray.withAlphaComponent(0.6)
                ]
            )
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            updateStyle()
        }
    }
    
    override var leftView: UIView? {
        didSet {
            leftView?.tintColor = UIColor.gray.withAlphaComponent(CGFloat(0.6))
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var bounds = super.leftViewRect(forBounds: bounds)
        bounds.origin.x += horizontalInset
        bounds.size.width -= horizontalInset - 5
        return bounds
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        var bounds = super.textRect(forBounds: bounds)
        bounds.origin.x += horizontalInset
        bounds.size.width -= horizontalInset * 2
        return bounds
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        var bounds = super.editingRect(forBounds: bounds)
        bounds.origin.x += horizontalInset
        bounds.size.width -= horizontalInset * 2
        return bounds
    }
    
    func setup() {
        layer.cornerRadius = cornerRadius
        borderStyle = UITextField.BorderStyle.none
        autocorrectionType = .no
        autocapitalizationType = .none

        updateStyle()
        
        addTarget(self, action: #selector(textFieldDidBeginEditing), for: .editingDidBegin)
        addTarget(self, action: #selector(textFieldDidEndEditing), for: .editingDidEnd)
    }
    
    @objc func textFieldDidBeginEditing() {
        superview?.bringSubviewToFront(self)
        updateStyle()
    }

    @objc func textFieldDidEndEditing() {
        updateStyle()
    }
    
    func updateStyle() {
        // setup styles depanding on design
        // for know we don't have instructions what to do if TextField is enabled or not
        leftView?.tintColor = UIColor.gray.withAlphaComponent(CGFloat(0.6))
        if isFirstResponder || text?.isEmpty == false {
            leftView?.tintColor = UIColor.black
        }
        backgroundColor = UIColor.gray.withAlphaComponent(CGFloat(0.12))
    }
}
