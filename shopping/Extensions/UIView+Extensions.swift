//
//  UIView+Extensions.swift
//  shopping
//
//  Created by Akın Özcan on 22.12.2023.
//

import UIKit

extension UIView {
    func setBottomViewShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.08
        self.layer.shadowOffset = CGSize(width: 0, height: -2)
        self.layer.shadowRadius = 4
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    }
}
