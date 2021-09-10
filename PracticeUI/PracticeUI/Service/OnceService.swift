//
//  OnceService.swift
//  PracticeUI
//
//  Created by a60105114 on 2021/09/09.
//

import Foundation

protocol OnceServiceProtocol {
    func start(_ completion: @escaping (Result<[Section], Error>) -> Void)
}

final class OnceService {
    var storage: FinanceDataStorageProtocol
    
    init(storage: FinanceDataStorageProtocol) {
        self.storage = storage
    }
}

extension OnceService: OnceServiceProtocol {
    func start(_ completion: @escaping (Result<[Section], Error>) -> Void) {
        
        // Storage try Load
        // or Network Request
        
        let result: [Section] = [
            Section(name: "예적금", items: ["Item1", "Item2", "Item3"], expandable: false),
            Section(name: "입출금", items: ["Item1", "Item2"], expandable: false),
            Section(name: "청약", items: ["Item1", "Item2", "Item3"], expandable: false),
            Section(name: "보험", items: ["Item1", "Item2", "Item3", "Item1", "Item2", "Item3"], expandable: false),
            Section(name: "부동산", items: ["Item1", "Item2"], expandable: false),
            Section(name: "자동차", items: ["Item1"], expandable: false),
            Section(name: "증권", items: ["Item1", "Item2", "Item3", "Item4", "Item5", "Item6", "Item7", "Item8", "Item9"], expandable: false),
            Section(name: "예적금", items: ["Item1", "Item2", "Item3"], expandable: false),
            Section(name: "입출금", items: ["Item1", "Item2"], expandable: false),
            Section(name: "청약", items: ["Item1", "Item2", "Item3"], expandable: false),
            Section(name: "보험", items: ["Item1", "Item2", "Item3", "Item1", "Item2", "Item3"], expandable: false),
            Section(name: "부동산", items: ["Item1", "Item2"], expandable: false),
            Section(name: "자동차", items: ["Item1"], expandable: false),
            Section(name: "증권", items: ["Item1", "Item2", "Item3", "Item4", "Item5", "Item6", "Item7", "Item8", "Item9"], expandable: false),
            Section(name: "예적금", items: ["Item1", "Item2", "Item3"], expandable: false),
            Section(name: "입출금", items: ["Item1", "Item2"], expandable: false),
            Section(name: "청약", items: ["Item1", "Item2", "Item3"], expandable: false),
            Section(name: "보험", items: ["Item1", "Item2", "Item3", "Item1", "Item2", "Item3"], expandable: false),
            Section(name: "부동산", items: ["Item1", "Item2"], expandable: false),
            Section(name: "자동차", items: ["Item1"], expandable: false),
            Section(name: "증권", items: ["Item1", "Item2", "Item3", "Item4", "Item5", "Item6", "Item7", "Item8", "Item9"], expandable: false)
        ]
        
        completion(.success(result))
    }
}
