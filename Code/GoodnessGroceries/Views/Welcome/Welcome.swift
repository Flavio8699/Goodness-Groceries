/*
 Source (modified): https://github.com/gregiOS/PageViewer
 */

import SwiftUI

struct Welcome: View {
    
    @EnvironmentObject var UserSettings: UserSettings
    @State private var offset: CGFloat = 0
    @State private var isUserSwiping: Bool = false
    @State private var canSwipe: Bool = true
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .center, spacing: 0) {
                    Welcome_page1().frame(width: geometry.size.width,
                                          height: geometry.size.height).contentShape(Rectangle())
                    Welcome_page2().frame(width: geometry.size.width,
                                          height: geometry.size.height).contentShape(Rectangle())
                    Welcome_page3().frame(width: geometry.size.width,
                                          height: geometry.size.height).contentShape(Rectangle())
                    Welcome_page4().frame(width: geometry.size.width,
                                          height: geometry.size.height).contentShape(Rectangle())
                    Welcome_page5().frame(width: geometry.size.width,
                                          height: geometry.size.height).contentShape(Rectangle())
                    Welcome_page6().frame(width: geometry.size.width,
                                          height: geometry.size.height).contentShape(Rectangle())
                }
            }
            .content
            .offset(x: self.isUserSwiping ? self.offset : CGFloat(UserSettings.step) * -geometry.size.width)
            .frame(width: geometry.size.width, alignment: .leading)
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        self.isUserSwiping = true
                        hideKeyboard()
                        self.offset = value.translation.width + -geometry.size.width * CGFloat(UserSettings.step)
                    })
                    .onEnded({ value in
                        if value.predictedEndTranslation.width < geometry.size.width / 2, UserSettings.step < 6 - 1 { // 6 = welcome pages before authentication request
                            UserSettings.step += 1
                        }
                        if value.predictedEndTranslation.width > geometry.size.width / 2, UserSettings.step > 0 {
                            UserSettings.step -= 1
                        }
                        withAnimation {
                            self.isUserSwiping = false
                        }
                    })
            )
        }
    }
}

