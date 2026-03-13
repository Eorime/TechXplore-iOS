//
//  MainTabView.swift
//  TechXplore
//
//  Created by Eorime on 13.03.26.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var router: AppRouter
    @State private var selectedTab = 1
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor(named: "AppCyan")?.withAlphaComponent(0.5)
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            TransactionsView()
                .padding(.horizontal, 5)
                .tabItem { Label("", image: "transactions") }
                .tag(0)
            MainView(selectedTab: $selectedTab)
                .padding(.horizontal, 5)
                .tabItem { Label("", image: "home") }
                .tag(1)
            MerchantsView()
                .padding(.horizontal, 5)
                .tabItem { Label("", image: "shops") }
                .tag(2)
        }
        .tint(Color("AppCyan"))
    }
}
