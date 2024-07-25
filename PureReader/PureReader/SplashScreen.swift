//
//  SplashScreen.swift
//  PureReader
//
//  Created by Prateek Mahendrakar on 7/24/24.
//

import SwiftUI

struct SplashScreen: View {
    @State private var scale = 0.25
    @Binding var isActive: Bool

    var body: some View {
        GeometryReader { proxy in
            VStack {
                Image("Logo")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .scaledToFit()
                    .scaleEffect(scale)
                    .ignoresSafeArea(.all)
                    .onAppear {
                        withAnimation(.bouncy(duration: 0.75, extraBounce: 0.5)) {
                            self.scale = 1.25
                        }
                        withAnimation(.easeOut(duration: 0.75)) {
                            self.scale = 1
                        }
                    }
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
            .background(Color.appPrimaryColor)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashScreen(isActive: Binding.constant(false))
}
