//
//  Dynamic.swift
//  PracticeUI
//
//  Created by a60105114 on 2021/09/09.
//

import Foundation

class Dynamic<T> {
    typealias Listener = (T) -> ()

    var listeners: [Listener?] = []
    var value: T {
        didSet {
            for listener in listeners {
                listener?(value)
            }
        }
    }

    init(_ value: T) {
        self.value = value
    }

    // MARK : - Listener Register & Not Call Closure

    func bind(_ listener: Listener?) {
        self.listeners.append(listener)
    }

    // MARK : - Listener Register & Call Closuer

    func bindAndFire(_ listener: Listener?) {
        self.listeners.append(listener)
        listener?(value)
    }

    func disposed() {
        if !listeners.isEmpty {
            listeners.removeLast()
        }
    }
}
