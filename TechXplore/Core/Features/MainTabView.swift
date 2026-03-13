//
//  MainTabView.swift
//  TechXplore
//
//  Created by Eorime on 13.03.26.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var router: AppRouter
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor(named: "AppCyan")?.withAlphaComponent(0.5)
    }
    
    var body: some View {
        TabView {
            TransactionsView()
                .padding(.horizontal, 20)
                .tabItem { Label("", image: "transactions") }
            MainView()
                .padding(.horizontal, 20)
                .tabItem { Label("", image: "home") }
            MerchantsView()
                .padding(.horizontal, 20)
                .tabItem { Label("", image: "shops") }
        }
        .tint(Color("AppCyan"))
    }
}
