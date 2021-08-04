//
//  NSObject+Extension.swift
//  PracticeUI
//
//  Created by 장용범 on 2021/08/04.
//

import Foundation

extension NSObject {
    class var reuseIdentifier: String {
        return String(describing: self)
    }
}
