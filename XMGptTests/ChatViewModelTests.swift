//
//  ChatViewModelTests.swift
//  XMGptTests
//
//  Created by RightMac-Rene on 31/03/2025.
//

import Foundation

import XCTest
@testable import XMGpt

@MainActor
final class ChatViewModelTests: XCTestCase {
    var viewModel: ChatViewModel!
    var mockRepository: MockChatRepository!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockChatRepository()
        let useCase = SendChatMessageUseCase(repository: mockRepository)
        viewModel = ChatViewModel(sendMessageUseCase: useCase)
    }
    
    func testSendMessage_Success() async {
        mockRepository.responseChunks = ["Hello", " there!"]
        
        XCTAssertTrue(viewModel.messages.isEmpty)
        await viewModel.sendMessage("Hi")
        
        XCTAssertEqual(viewModel.messages.count, 2) // User + Assistant
        XCTAssertEqual(viewModel.messages.first?.text, "Hi")
        XCTAssertEqual(viewModel.messages.last?.text, "Hello there!")
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.error)
    }
    
    func testSendMessage_Error() async {
        mockRepository.shouldThrowError = true
        
        await viewModel.sendMessage("Hi")
        
        XCTAssertEqual(viewModel.messages.count, 2) // User + Error message
        XCTAssertEqual(viewModel.messages.first?.text, "Hi")
        XCTAssertTrue(((viewModel.messages.last?.text.contains("Error")) != nil))
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNotNil(viewModel.error)
    }
}
