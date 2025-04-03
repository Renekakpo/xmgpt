//
//  ChatMessage.swift
//  XMGpt
//
//  Created by RightMac-Rene on 29/03/2025.
//

import Foundation
import GoogleGenerativeAI

/**
 * Represents a single chat message in the conversation.
 * Conforms to `Identifiable` for SwiftUI list handling and `Equatable` for comparison.
 */
struct ChatMessage: Identifiable, Equatable {
    let id = UUID()
    var text: String
    let isUser: Bool
}
