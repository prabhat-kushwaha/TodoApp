//
//  TodoAppsApp.swift
//  TodoApps
//
//  Created by Prabhat on 3/1/25.
//

import SwiftUI

@main
struct TodoAppsApp: App {
    @StateObject var viewModel = TodoViewModel.shared
    @State var isActive: Bool = false
    var body: some Scene {
        WindowGroup {
            ZStack{
                if isActive {
                    TodoList()
                }
            }.onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    isActive = true
                }
            }
        }
        
        .environmentObject(viewModel)
    }
}
