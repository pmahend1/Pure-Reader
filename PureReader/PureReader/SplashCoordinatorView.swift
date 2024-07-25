//
//  SplashCoordinatorView.swift
//  PureReader
//
//  Created by Prateek Mahendrakar on 7/24/24.
//

import SwiftUI

struct SplashCoordinatorView: View {
    @State private var isActive = false
    var body: some View {
        if isActive {
            HomeView()
        } else {
            SplashScreen(isActive: $isActive)
        }
    }
}

#Preview {
    SplashCoordinatorView()
}
