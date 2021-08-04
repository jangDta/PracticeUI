//
//  UIColor+Extension.swift
//  PracticeUI
//
//  Created by 장용범 on 2021/08/04.
//

import Foundation
import UIKit

extension UIColor {
    static var random: UIColor {
        UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1)
    }
}
