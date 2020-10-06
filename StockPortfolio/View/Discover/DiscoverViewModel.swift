//
//  DiscoverViewModel.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 04/10/2020.
//

import Foundation

import Foundation
import SwiftUI
import Combine
import CoreData

class DiscoverViewModel: ObservableObject {
    @Published var quotes = [Quote]()

    private var cancellables = Set<AnyCancellable>()
    private let api: API

    init(api: API = API()) {
        self.api = api
    }

    func request(listIndex: Int) {
        guard let listType = ListType(rawValue: listIndex) else { return }
        api
            .marketInfo(listType: listType.apiDescription)
            .sink { result in
                switch result {
                case .success(let quotes): self.quotes = quotes
                case.failure(let error): print(error.localizedDescription)
                }
            }.store(in: &cancellables)
    }
}