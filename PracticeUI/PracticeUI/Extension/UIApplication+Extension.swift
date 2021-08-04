//
//  UIApplication+Extension.swift
//  PracticeUI
//
//  Created by 장용범 on 2021/08/04.
//

import UIKit

extension UIApplication {
    var statusBarHeight: CGFloat {
        connectedScenes
            .compactMap {
                $0 as? UIWindowScene
            }
            .compactMap {
                $0.statusBarManager
            }
            .map {
                $0.statusBarFrame
            }
            .map(\.height)
            .max() ?? 0
    }
}
