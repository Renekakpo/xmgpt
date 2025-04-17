//
//  DIContainer.swift
//  XMGpt
//
//  Created by RightMac-Rene on 03/04/2025.
//

import Swinject

class DIContainer {
    static let shared = DIContainer()
    let container: Container

    private init() {
        container = Container()
        registerDependencies()
    }

    private func registerDependencies() {
        container.register(ChatRepositoryProtocol.self) { _ in
            GeminiChatRepository(apiKey: Environment.apiKey)
        }

        container.register(SendChatMessageUseCase.self) { r in
            SendChatMessageUseCase(repository: r.resolve(ChatRepositoryProtocol.self)!)
        }

        container.register(ChatViewModel.self) { r in
            return MainActor.assumeIsolated {
                ChatViewModel(sendMessageUseCase: r.resolve(SendChatMessageUseCase.self)!)
            }
        }
    }
}
