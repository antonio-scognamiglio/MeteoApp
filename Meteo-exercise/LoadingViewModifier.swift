//
//  LoadingViewModifier.swift
//  Meteo-exercise
//
//  Created by Antonio Scognamiglio on 17/07/23.
//

import SwiftUI


struct LoadingViewModifier: ViewModifier {
    @Binding var isShowingLoading: Bool
    var message: String
    var isShowingBackgroundColor: Bool
    var backgroundColor: Color = .white
    
    func body(content: Content) -> some View {
        content
            .blur(radius: isShowingLoading ? 5 : 0)
            .overlay {
                if isShowingLoading {
                    ZStack {
                        if isShowingBackgroundColor {
                            Color.cardColor2
                                .colorMultiply(.backgroundColor2)
                                .frame(width: UIScreen.main.bounds.width / 1.9, height: UIScreen.main.bounds.height / 4.9)
                                .opacity(0.8)
                                .cornerRadius(15)
                        }
                        VStack(spacing: 20) {
                            ProgressView()
                                .scaleEffect(2)
                            Text(message)
                                .fixedSize()
                                .font(.headline)
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                        }
                    }
                }
            }
    }
    
}


extension View {
    func showLoadingView(isShowingLoading: Binding<Bool>, message: String, isShowingBackgroundColor: Bool = false, backgroundColor: Color = .white) -> some View {
        modifier(LoadingViewModifier(isShowingLoading: isShowingLoading, message: message, isShowingBackgroundColor: isShowingBackgroundColor, backgroundColor: backgroundColor))
    }
}

