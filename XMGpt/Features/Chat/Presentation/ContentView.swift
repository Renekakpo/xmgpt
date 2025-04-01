//
//  ContentView.swift
//  XMGpt
//
//  Created by RightMac-Rene on 29/03/2025.
//

import SwiftUI
import GoogleGenerativeAI

struct ContentView: View {
    @EnvironmentObject var viewModel: ChatViewModel
    @State private var userInput: String = ""
    
    // For scrolling to bottom
    @State private var lastMessageId: UUID?
    
    var body: some View {
        VStack {
            Text("XMGPT Chat")
                .font(.title)
            
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(viewModel.messages) { message in
                            ChatBubble(text: message.text, isUser: message.isUser)
                                .id(message.id) // Track each message
                        }
                        if viewModel.isLoading && userInput.isEmpty {
                            HStack {
                                ProgressView()
                                    .padding(.leading, 8)
                                Text("Thinking...")
                                    .foregroundColor(.gray)
                                Spacer()
                            }
                            .id("loading") // ID for scrolling
                        }
                    }
                    .onChange(of: viewModel.messages) { newMessages, _ in
                        if let lastMessage = newMessages.last {
                            lastMessageId = lastMessage.id
                            DispatchQueue.main.async {
                                withAnimation {
                                    proxy.scrollTo(lastMessage.id, anchor: .bottom)
                                }
                            }
                        }
                    }
                }
                .padding()
            }
            
            Divider()
            
            HStack {
                TextField("Type a message...", text: $userInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(minHeight: 40)
                    .disabled(viewModel.isLoading)
                    .onSubmit {
                        sendMessage()
                    }
                
                Button(action: sendMessage) {
                    if viewModel.isLoading {
                        ProgressView()
                            .frame(width: 20, height: 20)
                    } else {
                        Image(systemName: "paperplane.fill")
                            .foregroundColor(.blue)
                    }
                }
                .disabled(userInput.isEmpty || viewModel.isLoading)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
        }
    }
    
    func sendMessage() {
        let messageToSend = userInput
        userInput = ""
        
        Task {
            await viewModel.sendMessage(messageToSend)
        }
    }
}

#Preview {
    ContentView()
}
