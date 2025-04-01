//
//  ChatBubble.swift
//  XMGpt
//
//  Created by RightMac-Rene on 29/03/2025.
//

import SwiftUI
import MarkdownUI

struct ChatBubble: View {
    let text: String
    let isUser: Bool
    
    var body: some View {
        HStack {
            if isUser { Spacer() }
            
            Markdown(text)
                .padding()
                .background(isUser ? Color.blue : Color.gray.opacity(0.2))
                .foregroundColor(isUser ? .white : .black)
                .cornerRadius(15)
                .frame(maxWidth: .infinity, alignment: isUser ? .trailing : .leading)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, 5)
            
            if !isUser { Spacer() }
        }
    }
}

#Preview {
    ChatBubble(text: "Lorem ipsum", isUser: true)
}
