//
//  ChatBubble.swift
//  XMGpt
//
//  Created by RightMac-Rene on 29/03/2025.
//

import SwiftUI

struct ChatBubble: View {
    let text: String
    let isUser: Bool
    
    var body: some View {
        HStack {
            if isUser { Spacer() }
            
            renderMarkdown(text)
                .padding()
                .background(isUser ? Color.blue : Color.gray.opacity(0.2))
                .foregroundColor(isUser ? .white : .black)
                .cornerRadius(15)
                .frame(maxWidth: 300, alignment: isUser ? .trailing : .leading)
                .padding(.horizontal, 5)
            
            if !isUser { Spacer() }
        }
    }
    
    func renderMarkdown(_ text: String) -> Text {
        if let attributedString = try? AttributedString(markdown: text) {
            return Text(attributedString)
        } else {
            return Text(text) // Fallback for unsupported formatting
        }
    }
}

#Preview {
    ChatBubble(text: "Lorem ipsum", isUser: true)
}
