//
//  XMGptApp.swift
//  XMGpt
//
//  Created by RightMac-Rene on 29/03/2025.
//

import SwiftUI

@main
struct XMGptApp: App {    
    let chatViewModel = DIContainer.shared.container.resolve(ChatViewModel.self)!
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(chatViewModel) // Injects `ChatViewModel` into the SwiftUI environment.
        }
    }
}
