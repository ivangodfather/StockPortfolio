//
//  PriceTargetView.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 16/10/2020.
//

import SwiftUI

struct PriceTargetView: View {
    let numberOfAnalysts: Int
    let priceTargetLow: Double
    let priceTargetHigh: Double
    let priceTargetAverage: Double
    let currentPrice: Double

    var body: some View {
        VStack {
            Title("Analysts Price Target").padding(.bottom, 40)
            VStack(alignment: .leading, spacing: 0) {
                GeometryReader { geo in
                    PinmarkView()
                        .modifier(BackgroundModifier(
                                    text: "Average\n\(priceTargetAverage.round2())",
                                    color: Color.Stock.gray,
                                    yOffset: -32)
                        )
                        .offset(x: calculateOffset(geo.size.width, value: priceTargetAverage), y: -20)
                    PinmarkView(color: Color.blue)
                        .rotationEffect(.degrees(180))
                        .modifier(BackgroundModifier(
                                    text: "Current\n\(currentPrice.round2())",
                                    color: .blue,
                                    yOffset: 32)
                        )
                        .offset(x: calculateOffset(geo.size.width, value: currentPrice), y: 0)
                    HStack(spacing: 0) {
                        PriceCircleView()
                        Rectangle()
                            .fill(Color.gray.opacity(0.5))
                            .frame(height: 2)
                        PriceCircleView()
                    }
                    HStack {
                        Text("Low \(priceTargetLow.round2())")
                        Spacer()
                        Text("High \(priceTargetHigh.round2())")
                    }
                    .padding(.top, 8)
                    .font(.system(size: 10))
                }.frame(height: 100)
            }
        }.padding()
    }

    private func calculateOffset(_ width: CGFloat, value: Double) -> CGFloat {
        CGFloat((value - priceTargetLow) / (priceTargetHigh - priceTargetLow)) * width
    }
}

private struct BackgroundModifier: ViewModifier {
    let text: String
    let color: Color
    let yOffset: CGFloat
    func body(content: Content) -> some View {
        content
            .background(
                Text(text)
                    .foregroundColor(color)
                    .bold()
                    .fixedSize()
                    .offset(x: 0, y: yOffset)
                    .font(.caption)
            )
    }


}

struct PriceTargetView_Previews: PreviewProvider {
    static var previews: some View {
        PriceTargetView(numberOfAnalysts: 34, priceTargetLow: 220.05, priceTargetHigh: 320.15, priceTargetAverage: 250.05, currentPrice: 240.99)
    }
}

private struct PriceCircleView: View {
    var body: some View {
        Circle()
            .fill(Color.gray)
            .frame(width: 8, height: 8)
    }
}

private struct PinmarkView: View {
    var color: Color = Color.Stock.gray
    var body: some View {
        VStack(spacing: 0.0) {
            Rectangle()
                .fill(color)
                .frame(width: 2, height: 20)
            Circle()
                .strokeBorder(color)
                .frame(width: 8, height: 8)
        }
    }
}

struct PriceTargetView_Previews_2: PreviewProvider {
    static var previews: some View {
        PinmarkView().previewLayout(.sizeThatFits)
    }
}
