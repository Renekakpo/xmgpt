//
//  ChatRepositoryProtocol.swift
//  XMGpt
//
//  Created by RightMac-Rene on 31/03/2025.
//

import Foundation
import GoogleGenerativeAI

/**
 * Defines a contract for handling AI chat interactions.
 * Implementing this protocol makes it easier to switch between different AI providers or mock implementations for testing.
 */
protocol ChatRepositoryProtocol {
    /**
     * Sends a message to the AI model and returns a stream of responses.
     
     * - Parameters:
     *   - text: The message content sent by the user.
     *   - history: A list of previous messages to maintain conversation context.
     *
     * - Returns: An `AsyncThrowingStream<String, Error>` that asynchronously provides
     *   the response from the AI model in a streaming manner.
     *
     * - Throws: An error if there is an issue with the API request or response processing.
     */
    func sendMessageStream(_ text: String, history: [ModelContent]) async throws -> AsyncThrowingStream<String, Error>
}
