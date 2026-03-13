//
//  MainTabView.swift
//  TechXplore
//
//  Created by Eorime on 13.03.26.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var router: AppRouter
    
    var body: some View {
        TabView {
            Text("Tab 1")
                .tabItem { Label("", systemImage: "house") }
            Text("Tab 2")
                .tabItem { Label("", systemImage: "magnifyingglass") }
            Text("Tab 3")
                .tabItem { Label("", systemImage: "person") }
        }
    }
}
