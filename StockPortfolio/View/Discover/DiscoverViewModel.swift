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

    @Published var collections = [Collection]()

    private var cancellables = Set<AnyCancellable>()
    private let numberOfNewsXItem = 3

    private let api: API

    init(api: API = API()) {
        self.api = api
    }

    func requestCollection(type: CollectionType) {
        api.collections(type: type.description).sink { result in
            switch result {
            case .success(let collections): self.collections = collections
            case.failure(let error): print(error.localizedDescription)
            }
        }.store(in: &cancellables)
    }
}
