//
//  XMGptApp.swift
//  XMGpt
//
//  Created by RightMac-Rene on 29/03/2025.
//

import SwiftUI

@main
struct XMGptApp: App {    
    @StateObject
    private var viewModel: ChatViewModel
    
    /**
     * Initializes and sets up dependencies following DI pattern
     */
    init() {
        // Instanciate repository responsible for API communication
        let repository = GeminiChatRepository(
            apiKey: Environment.apiKey
        )
        // Instanciate the use case that handles sending message
        let useCase = SendChatMessageUseCase(repository: repository)
        // Initializes the viewModel with the use case
        _viewModel = StateObject(wrappedValue: ChatViewModel(sendMessageUseCase: useCase))
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel) // Injects `ChatViewModel` into the SwiftUI environment.
        }
    }
}
