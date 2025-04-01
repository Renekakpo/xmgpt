//
//  ViewModel.swift
//  XMGpt
//
//  Created by RightMac-Rene on 30/03/2025.
//

import Foundation
import GoogleGenerativeAI

/**
 * ViewModel for chat functionality.
 * Manages message state, loading indicators, and error handling.
 * MainActor ensures UI updates happen on main thread.
 */
@MainActor
class ChatViewModel: ObservableObject {
    // Comment goes here
    @Published
    var messages: [ChatMessage] = []
    
    @Published
    var isLoading = false
    
    @Published
    var error: String?
    
    // Comment goes here
    private let sendMessageUseCase: SendChatMessageUseCase
    
    /**
     * Initializes the ViewModel with required dependencies.
     * @param sendMessageUseCase The use case handling message sending logic
     */
    init(sendMessageUseCase: SendChatMessageUseCase) {
        self.sendMessageUseCase = sendMessageUseCase
    }
    
    /**
     * Handles sending a new message and processing the response.
     * @param text The user's message text
     * - Appends user message immediately
     * - Streams assistant response with typing animation
     * - Handles errors gracefully
     */
    func sendMessage(_ text: String) async {
        let userMessage = ChatMessage(text: text, isUser: true)
        messages.append(userMessage)
        isLoading = true
        error = nil
        
        do {
            // Get streaming response from use case
            let stream = try await sendMessageUseCase.execute(
                text: text,
                history: messages.map { $0.modelContent! }
            )
            
            // Create empty assistant message to fill progressively
            let assistantMessage = ChatMessage(text: "", isUser: false)
            messages.append(assistantMessage)
            
            // Process response stream with typing effect
            for try await chunk in stream {
                // Append each character progressively for a typing effect
                for char in chunk {
                    if let lastIndex = messages.indices.last {
                        messages[lastIndex].text.append(char)
                        try await Task.sleep(nanoseconds: 30_000_000) // 50ms delay per character
                    }
                }
            }
        } catch {
            self.error = error.localizedDescription
            messages.append(ChatMessage(text: "Error: \(error.localizedDescription)", isUser: false))
        }
        
        isLoading = false
    }
}
