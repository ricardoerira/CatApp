//
//  SplashScreen.swift
//  CatAppTest
//
//  Created by Wilson Ricardo Erira  on 4/04/25.
//

import Foundation
import SwiftUI
import Lottie

struct SplashScreen: View {
    @State private var isActive = false
    @State private var offsetY: CGFloat = 700
    @State private var width: CGFloat = 0
    @State private var height: CGFloat = 0
    
    var body: some View {
        ZStack {
            if isActive {
                CatBreedListView(viewModel:  AppFactory.shared.makeBreedListViewModel())
                // Navigate to the main content
            } else {
                VStack {
                    VStack {
                        LottieView(animationName: "animation_welcome")
                            .frame(width: width, height: height) .offset(y: offsetY)
                            .onAppear {
                                withAnimation(.easeOut(duration: 2.0)) {
                                    offsetY = 100
                                    width = 500
                                    height = 500
                                }
                            }
                    }
                    
                    
                    Spacer()
                    arc()
                }
                
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            isActive = true
                        }
                    }
                }
            }
        }
        
        .ignoresSafeArea() // Make it full screen
    }
    
    
    @ViewBuilder private func arc() -> some View {
        
        ZStack {
            
            Circle()
                .fill(Color.purple) // Use the desired color
                .frame(width: UIScreen.main.bounds.width * 1.2, height: UIScreen.main.bounds.width * 1.2)
                .offset(y: UIScreen.main.bounds.height * 0.4) // Adjust the position
            
            VStack {
                
                Text( "CatApp")
                    .font(.custom("FlowExt", size: 36))
                    .foregroundStyle(.purple).multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
            }
        }
        
    }
    
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
