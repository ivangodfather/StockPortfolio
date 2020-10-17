//
//  DiscoverViewModel.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 04/10/2020.
//

import Foundation
import SwiftUI
import Combine
import CoreData

class DiscoverViewModel: ObservableObject {
    @Published var quotesDetails = [QuoteDetail]()

    private var cancellables = Set<AnyCancellable>()
    private let api: APIProtocol

    init(api: APIProtocol = API()) {
        self.api = api
    }

    func request(listIndex: Int) {
        guard let listType = ListType(rawValue: listIndex) else { return }
        api
            .marketInfo(listType: listType.apiDescription)
            .sink { result in
                switch result {
                case .success(let quotesDetails):
                    self.quotesDetails = quotesDetails
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }.store(in: &cancellables)
    }
}
