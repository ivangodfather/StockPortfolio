//
//  PriceTargetView.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 16/10/2020.
//

import SwiftUI

struct PriceTargetView: View {
    
    let priceTarget: PriceTarget
    let currentPrice: Double
    
    var body: some View {
        VStack {
            if (priceTarget.low...priceTarget.high) ~= priceTarget.average &&
                priceTarget.low < priceTarget.high {
                BodyView(priceTarget: priceTarget, currentPrice: currentPrice)
            }
        }
    }
    

}

fileprivate struct BodyView: View {
    let priceTarget: PriceTarget
    let currentPrice: Double

    var body: some View {
        GroupBox(label: Title("Analysts Price Target").padding(.bottom, 56)) {
            VStack(alignment: .leading, spacing: 0) {
                GeometryReader { geo in
                    PinmarkView()
                        .modifier(BackgroundModifier(
                                    text: "Average\n\(priceTarget.average.round2())",
                                    yOffset: -32)
                        )
                        .offset(x: calculateOffset(geo.size.width, value: priceTarget.average), y: -20)
                    PinmarkView(color: Color.accentColor)
                        .rotationEffect(.degrees(180))
                        .modifier(BackgroundModifier(
                                    text: "Current\n\(currentPrice.round2())",
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
                        Text("Low \(priceTarget.low.round2())")
                        Spacer()
                        Text("High \(priceTarget.high.round2())")
                    }
                    .padding(.top, 8)
                    .font(.system(size: 10))
                }.frame(height: 64)
            }
        }.groupBoxStyle(MyGroupBoxStyle())
    }

    private func calculateOffset(_ width: CGFloat, value: Double) -> CGFloat {
        CGFloat((value - priceTarget.low) / (priceTarget.high - priceTarget.low)) * width
    }
}

private struct BackgroundModifier: ViewModifier {
    let text: String
    let yOffset: CGFloat
    func body(content: Content) -> some View {
        content
            .background(
                Text(text)
                    .foregroundColor(.white)
                    .bold()
                    .fixedSize()
                    .offset(x: 0, y: yOffset)
                    .font(.caption)
            )
    }
    
    
}

struct PriceTargetView_Previews: PreviewProvider {
    static let priceTarget = PriceTarget(average: 70.30, high: 90.4, low: 60.95, numberOfAnalysts: 31)
    static var previews: some View {
        PriceTargetView(priceTarget: PriceTargetView_Previews.priceTarget, currentPrice: 82.234)
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
    var color: Color = Color.accentColor
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
