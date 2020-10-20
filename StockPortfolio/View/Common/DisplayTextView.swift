//
//  DisplayTextView.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 20/10/2020.
//

import SwiftUI

struct DisplayTextView: View {
    let title: String
    let content: String

    var body: some View {
        GroupBox(label: Title(title)) {
            Text(content)
        }.groupBoxStyle(MyGroupBoxStyle())
    }
}

struct DisplayTextView_Previews: PreviewProvider {
    static var previews: some View {
        DisplayTextView(title: "Test title", content:
"""
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vitae ultricies est, a feugiat odio. Phasellus hendrerit urna vitae tellus malesuada, sit amet viverra velit viverra. Vestibulum vestibulum eros quis mauris lobortis, eget volutpat enim volutpat. Morbi ut porta augue, et dapibus libero. Nunc volutpat, nulla at sodales pulvinar, dolor magna auctor odio, eget faucibus massa nisi sollicitudin nisl. Fusce efficitur elit eu velit bibendum, et laoreet justo pretium. Duis viverra sollicitudin magna nec malesuada.

Fusce id ligula sit amet mauris rutrum venenatis sed sed felis. Sed posuere vehicula mauris, id viverra libero sodales vel. Nam sed tortor dignissim, efficitur arcu ut, pharetra lorem. Integer in dui rutrum, congue purus id, lobortis quam. Donec malesuada urna ut vulputate dapibus. Ut viverra purus accumsan, facilisis dolor ut, bibendum nisl. Ut tincidunt risus vitae sapien eleifend, aliquam pellentesque turpis pretium. Quisque ullamcorper finibus quam. Vestibulum pretium ultricies finibus.
"""

                        )
    }
}
