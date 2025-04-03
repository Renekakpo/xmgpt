//
//  SendChatMessageUseCase.swift
//  XMGpt
//
//  Created by RightMac-Rene on 31/03/2025.
//

import Foundation
import GoogleGenerativeAI

/**
 * Handles the business logic for sending chat messages.
 * Coordinates with the data layer to stream chat responses.
 */
class SendChatMessageUseCase {
    private let repository: ChatRepositoryProtocol
    
    /**
     * Initializes the use case with a chat repository.
     * - Parameter repository: The data source for sending/streaming messages
     */
    init(repository: ChatRepositoryProtocol) {
        self.repository = repository
    }
    
    /**
     * Executes the message sending operation.
     * - Parameters:
     *   - text: The user's message text
     *   - history: Conversation history for context
     * - Returns: Async stream that yields partial responses or throws errors
     */
    func execute(text: String, history: [ChatMessage]) async throws -> AsyncThrowingStream<String, Error> {
        try await repository.sendMessageStream(text, history: history)
    }
}
