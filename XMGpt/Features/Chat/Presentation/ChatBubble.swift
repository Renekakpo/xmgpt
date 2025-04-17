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
    @State private var showCopiedIndicator = false
    
    var body: some View {
        HStack {
            if isUser { Spacer() }
            
            VStack(alignment: isUser ? .trailing : .leading) {
                Markdown(text)
                    .padding()
                    .background(isUser ? Color.blue.opacity(0.3) : Color.gray.opacity(0.2))
                    .foregroundColor(isUser ? .white : .black)
                    .cornerRadius(15)
                    .frame(maxWidth: .infinity, alignment: isUser ? .trailing : .leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal, 5)
                
                Image(systemName: showCopiedIndicator ? "checkmark" : "doc.on.doc")
                    .font(.system(size: 14))
                    .foregroundColor(isUser ? .blue : .gray)
                    .padding(.horizontal, 10)
                    .onTapGesture {
                        UIPasteboard.general.string = text
                        showCopiedIndicator = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            showCopiedIndicator = false
                        }
                    }
            }
            .frame(maxWidth: .infinity, alignment: isUser ? .trailing : .leading)
            
            if !isUser { Spacer() }
        }
        .padding(.horizontal, 5)
    }
}

#Preview {
    ChatBubble(text: "Lorem ipsum", isUser: true)
}
