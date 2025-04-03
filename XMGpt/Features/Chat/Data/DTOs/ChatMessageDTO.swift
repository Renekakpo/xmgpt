//
//  ChatMessageDTO.swift
//  XMGpt
//
//  Created by RightMac-Rene on 03/04/2025.
//

import Foundation
import GoogleGenerativeAI

/**
 * Data Transfer Object (DTO) for chat messages used in API communication.
 * Converts between `ModelContent` and `ChatMessage`.
 */
struct ChatMessageDTO: Codable {
    var text: String
    let role: String
    
    /**
     * Converts DTO to ModelContent for AI processing.
     */
    func toModelContent() -> ModelContent? {
        return try? ModelContent(role: role, parts: [text])
    }
    
    /**
     * Converts DTO to a domain model (`ChatMessage`).
     */
    func toDomainModel() -> ChatMessage {
        return ChatMessage(text: text, isUser: role == "user")
    }
    
    /**
     * Creates a DTO from a domain model (`ChatMessage`).
     */
    static func fromDomainModel(_ message: ChatMessage) -> ChatMessageDTO {
        return ChatMessageDTO(text: message.text, role: message.isUser ? "user" : "model")
    }
}
