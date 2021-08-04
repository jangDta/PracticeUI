//
//  UIActivityIndicatorView+Extension.swift
//  PracticeUI
//
//  Created by 장용범 on 2021/08/04.
//

import Foundation
import UIKit

extension UIActivityIndicatorView {
    func animate(_ animated: Bool) {
        if animated {
            isHidden = false
            startAnimating()
        } else {
            isHidden = true
            stopAnimating()
        }
    }
}
