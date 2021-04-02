import SwiftUI

struct IndicatorsView: View {
    
    let geometry: GeometryProxy
    var indicators: [Indicator]

    var body: some View {
        self.generateContent(in: geometry)
    }

    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .leading) {
            ForEach(self.indicators, id: \.self) { indicator in
                Image(indicator.icon_name)
                .padding([.trailing, .bottom], 12)
                .alignmentGuide(.leading, computeValue: { d in
                    if (abs(width - d.width) > g.size.width)
                    {
                        width = 0
                        height -= d.height
                    }
                    let result = width
                    if indicator == self.indicators.first! {
                        width = 0
                    } else {
                        width -= d.width
                    }
                    return result
                })
                .alignmentGuide(.top, computeValue: { d in
                    let result = height
                    if indicator == self.indicators.first! {
                        height = 0
                    }
                    return result
                })
            }
        }
    }
}
