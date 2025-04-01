//
//  GeminiChatRepository.swift
//  XMGpt
//
//  Created by RightMac-Rene on 31/03/2025.
//

import Foundation
import GoogleGenerativeAI

/**
 * Repository for handling chat interactions with Gemini AI.
 * Implements ChatRepositoryProtocol for consistent chat service interface.
 */
class GeminiChatRepository: ChatRepositoryProtocol {
    private var model: GenerativeModel
    
    /**
     * Initializes the Gemini chat model with provided API key.
     * Uses "gemini-1.5-flash" as the default model for quick responses.
     */
    init(apiKey: String) {
        self.model = GenerativeModel(
            name: "gemini-1.5-flash",
            apiKey: apiKey
        )
    }
    
    /**
     * Sends a message to Gemini and streams the response incrementally.
     * - Parameters:
     *   - text: User's input message
     *   - history: Conversation context for maintaining chat state
     * - Returns: Async stream of response chunks with error handling
     */
    func sendMessageStream(_ text: String, history: [ModelContent]) async throws -> AsyncThrowingStream<String, Error> {
        let chat = model.startChat(history: history)
        let response = chat.sendMessageStream(text)
        
        // Wrap the response in an AsyncThrowingStream for easier consumption
        return AsyncThrowingStream { continuation in
            Task {
                do {
                    // Process each response chunk as it arrives
                    for try await chunk in response {
                        if let text = chunk.text {
                            continuation.yield(text) // Send each text chunk to the caller
                        }
                    }
                    continuation.finish() // Signal successful completion
                } catch {
                    continuation.finish(throwing: error)
                }
            }
        }
    }
}
