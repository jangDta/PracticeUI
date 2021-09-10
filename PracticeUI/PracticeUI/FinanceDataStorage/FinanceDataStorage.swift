//
//  FinanceDataStorage.swift
//  PracticeUI
//
//  Created by a60105114 on 2021/09/09.
//

import Foundation

enum FinanceDataStorageError: Error {
    case nonExist
}

protocol FinanceDataStorageProtocol {
    func save(at index: FinanceIndex, data: [String : Any], completion: (Bool) -> Void)
    func load(at index: FinanceIndex, completion: (Result<[String : Any], Error>) -> Void)
}

class FinanceDataStorage: FinanceDataStorageProtocol {
    func load(at index: FinanceIndex, completion: (Result<[String : Any], Error>) -> Void) {
        if let result = UserDefaults.standard.dictionary(forKey: "\(index.rawValue)") {
            completion(.success(result))
        }
        completion(.failure(FinanceDataStorageError.nonExist))
    }
    
    func save(at index: FinanceIndex, data: [String : Any], completion: (Bool) -> Void) {
        UserDefaults.standard.set(data, forKey: "\(index.rawValue)")
    }
}
