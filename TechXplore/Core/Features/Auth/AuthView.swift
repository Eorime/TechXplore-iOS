//
//  AuthView.swift
//  TechXplore
//
//  Created by Eorime on 13.03.26.
//


import SwiftUI

struct AuthView: View {
    @EnvironmentObject var router: AppRouter
    
    var body: some View {
        LoginView()
            .environmentObject(router)
    }
}
