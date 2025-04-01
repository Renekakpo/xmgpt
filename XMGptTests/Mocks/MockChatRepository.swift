//
//  MockChatRepository.swift
//  XMGpt
//
//  Created by RightMac-Rene on 31/03/2025.
//

import Foundation
import GoogleGenerativeAI

class MockChatRepository: ChatRepositoryProtocol {
    var responseChunks: [String] = []
    var shouldThrowError = false
    
    func sendMessageStream(_ text: String, history: [ModelContent]) async throws -> AsyncThrowingStream<String, Error> {
        if shouldThrowError {
            throw NSError(domain: "TestError", code: 1, userInfo: nil)
        }
        
        return AsyncThrowingStream { continuation in
            Task {
                for chunk in responseChunks {
                    continuation.yield(chunk)
                    try? await Task.sleep(nanoseconds: 10_000_000) // Simulate delay
                }
                continuation.finish()
            }
        }
    }
}
