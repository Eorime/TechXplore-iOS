//
//  OnboardingView.swift
//  TechXplore
//
//  Created by Eorime on 13.03.26.
//


import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var router: AppRouter
    @StateObject private var viewModel = DIContainer.shared.makeQuizViewModel()
    
    var body: some View {
        QuizView(viewModel: viewModel)
            .padding(.horizontal, 30)
            .fullScreenCover(isPresented: $viewModel.quizComplete) {
                ResultView(result: viewModel.result ?? .gourmet) {
                    // quiz done → tell router
                    router.onboardingDidComplete(persona: viewModel.result ?? .gourmet)
                }
            }
    }
}
