//
//  CompanyLoadedStateView.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 14/10/2020.
//

import SwiftUI

struct CompanyLoadedStateView: View {
    @State private var selectedIndex = 0
    let companyDetail: CompanyDetail

    var body: some View {
        VStack {
            VStack(alignment: selectedIndex == 0 ? .leading : .trailing) {
                HStack {
                    CompanyHeaderTabButtonView(selectedIndex: $selectedIndex, text: "Summary", index: 0)
                    CompanyHeaderTabButtonView(selectedIndex: $selectedIndex, text: "Details", index: 1)
                }
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: UIScreen.main.bounds.width / 2, height: 2)
            }
            .font(.headline)
            TabView(selection: $selectedIndex) {
                CompanySummaryView(companyDetail: companyDetail)
                    .tag(0)
                CompanyDetailsView(companyDetail: companyDetail).tag(1)
            }.tabViewStyle(PageTabViewStyle())
        }
    }
}

struct CompanyLoadedStateView_Previews: PreviewProvider {
    static var previews: some View {
        CompanyLoadedStateView(companyDetail: .random)
    }
}
