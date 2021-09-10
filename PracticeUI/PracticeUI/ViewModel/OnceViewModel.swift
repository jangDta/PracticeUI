//
//  OnceViewModel.swift
//  PracticeUI
//
//  Created by a60105114 on 2021/09/09.
//

import Foundation

protocol OnceBusinessProtocol {
    var onceModel: Dynamic<[Section]> { get set }
    var reloadSection: Dynamic<Int> { get set }
    var onceService: OnceServiceProtocol { get }
    func load()
}

typealias OnceViewModelProtocol = OnceBusinessProtocol & AnimateCellProtocol

class OnceViewModel: OnceViewModelProtocol {
    var reloadSection: Dynamic<Int> = .init(0)
    
    var animatedIndexPaths: [IndexPath] = []
    
    var onceModel: Dynamic<[Section]> = .init([])
    
    var onceService: OnceServiceProtocol
    
    init(onceService: OnceServiceProtocol) {
        self.onceService = onceService
    }
    
    func load() {
        onceService.start { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                case .success(let data):
                    self.onceModel.value = data
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func toggle(at index: Int) {
        onceModel.value[index].expandable.toggle()
        reloadSection.value = index
    }
}
