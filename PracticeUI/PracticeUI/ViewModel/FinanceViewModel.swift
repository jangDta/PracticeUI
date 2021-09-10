//
//  FinanceViewModel.swift
//  PracticeUI
//
//  Created by a60105114 on 2021/09/09.
//

import Foundation

enum FinanceIndex: Int {
    case 한눈에 = 1
    case 자산 = 2
    case 소비 = 3
    case 목표 = 4
}

protocol FinanceIndexProtocol {
    var index: Dynamic<FinanceIndex> { get set }
    var currentIndex: FinanceIndex { get set }
}

protocol FinanceBusinessProtocol {
    var scrapingService: ScrapingServiceProtocol { get }
    func executeAllScraping()
}

protocol AnimateCellProtocol {
    var animatedIndexPaths: [IndexPath] { get set }
    func toggle(at index: Int)
}

extension AnimateCellProtocol {
    mutating func needAnimation(at indexPath: IndexPath) -> Bool {
        if animatedIndexPaths.contains(indexPath) {
            return false
        }
        animatedIndexPaths.append(indexPath)
        return true
    }
}

typealias FinanceViewModelProtocol = FinanceIndexProtocol & FinanceBusinessProtocol & AnimateCellProtocol

class FinanceViewModel: FinanceViewModelProtocol {
    
    var scrapingService: ScrapingServiceProtocol
    
    init(scrapingService: ScrapingServiceProtocol) {
        self.scrapingService = scrapingService
    }
    
    var index: Dynamic<FinanceIndex> = .init(.한눈에)
    var currentIndex: FinanceIndex {
        get {
            index.value
        }
        set {
            index.value = newValue
        }
    }
    
    var animatedIndexPaths: [IndexPath] = []
    
    func executeAllScraping() {
        scrapingService.executeAllScraping()
    }
    
    func toggle(at index: Int) {
        
    }
}
