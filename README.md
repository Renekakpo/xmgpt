# XMGpt - ChatGPT iOS App with Gemini API

XMGpt is a SwiftUI-powered iOS chat application that integrates with Google's Gemini AI API to provide intelligent chat functionalities. The app follows **Clean Architecture** principles, making it modular, scalable, and testable.

## 📌 Features
- Real-time AI chat powered by **Google Gemini API**.
- Smooth conversation experience with streaming responses.
- Clean and maintainable codebase with **MVVM + Clean Architecture**.
- Unit-tested **ChatViewModel** for reliability.
- Secure API key handling via `Info.plist`.

## 🏗️ Project Structure
The project is structured using **feature-based modularization** within a **Clean Architecture** framework:

```
XMGpt
│── App
│   ├── Environment  (Manages API keys and app-wide configurations)
│   ├── XMGptApp     (Main App Entry Point)
│
│── Features
│   ├── Chat
│   │   ├── Data
│   │   │   ├── Repositories
│   │   │   │   ├── ChatRepositoryProtocol.swift
│   │   │   │   ├── GeminiChatRepository.swift
│   │   ├── Domain
│   │   │   ├── Models
│   │   │   │   ├── ChatMessage.swift
│   │   │   ├── UseCases
│   │   │   │   ├── SendChatMessageUseCase.swift
│   │   ├── Presentation
│   │   │   ├── ViewModels
│   │   │   │   ├── ChatViewModel.swift
│   │   │   ├── Views
│   │   │   │   ├── ChatBubble.swift
│   │   │   │   ├── ContentView.swift
│
│── XMGptTests
│   ├── Mocks
│   │   ├── MockChatRepository.swift
│   ├── ChatViewModelTests.swift
│
│── Package Dependencies
│   ├── generative-ai-swift (Google Gemini API SDK)
```

## 🚀 Getting Started

### Prerequisites
- **Xcode 15+**
- **iOS 17+**
- **Swift 5.9+**
- A Google Gemini API key (Get it from [Google AI](https://ai.google.dev/))

### Setup Instructions
1. Clone the repository:
   ```sh
   git clone https://github.com/yourusername/XMGpt.git
   cd XMGpt
   ```
2. Install dependencies using Swift Package Manager.
3. Set up your **Google Gemini API Key**:
   - Create a `Secrets.xcconfig` file (or use `Info.plist`).
   - Add `GEMINI_API_KEY = "your-api-key"`.
4. Run the project on **Xcode Simulator** or a real device.

## 🏛️ Architectural Overview
### **1. Data Layer** (`Chat/Data`)
- Contains `GeminiChatRepository`, responsible for communicating with the Gemini API.
- Implements `ChatRepositoryProtocol` for dependency inversion.

### **2. Domain Layer** (`Chat/Domain`)
- Holds **business logic**.
- `SendChatMessageUseCase` manages the interaction between the repository and view model.

### **3. Presentation Layer** (`Chat/Presentation`)
- `ChatViewModel` is an **ObservableObject** handling UI state.
- Views like `ChatBubble.swift` display chat messages.

## 🛠️ Key Components
### **1. `ChatViewModel.swift` (Main ViewModel)**
Handles user input, API requests, and updates UI state:
```swift
@MainActor
class ChatViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = []
    @Published var isLoading = false
    @Published var error: String?
    
    private let sendMessageUseCase: SendChatMessageUseCase
    
    func sendMessage(_ text: String) async { ... }
}
```

### **2. `GeminiChatRepository.swift` (Data Layer)**
Fetches chat responses from the Gemini API using Google's Swift SDK:
```swift
func sendMessageStream(_ text: String, history: [ModelContent]) async throws -> AsyncThrowingStream<String, Error> {
    let chat = model.startChat(history: history)
    return chat.sendMessageStream(text)
}
```

### **3. `SendChatMessageUseCase.swift` (Business Logic Layer)**
Connects `ChatViewModel` to the `GeminiChatRepository`:
```swift
class SendChatMessageUseCase {
    func execute(text: String, history: [ModelContent]) async throws -> AsyncThrowingStream<String, Error> {
        return try await repository.sendMessageStream(text, history: history)
    }
}
```

## 🧪 Unit Testing
Located in `XMGptTests/`:
- `MockChatRepository.swift` mocks API responses for isolated testing.
- `ChatViewModelTests.swift` tests `ChatViewModel` behavior.
- Uses `XCTest` framework for validation.

Example Test Case:
```swift
func testSendMessage_SuccessfulResponse() async {
    let mockRepo = MockChatRepository()
    let useCase = SendChatMessageUseCase(repository: mockRepo)
    let viewModel = ChatViewModel(sendMessageUseCase: useCase)
    
    await viewModel.sendMessage("Hello")
    XCTAssertEqual(viewModel.messages.last?.text, "Hello AI!")
}
```

## 📜 License
This project is licensed under the **MIT License**. See the [LICENSE](./LICENSE) file for details.

## 👨‍💻 Author
- **René KAKPO**  
- [GitHub](https://github.com/Renekakpo)  
- [LinkedIn](https://www.linkedin.com/in/renekakpo)  

---

This README provides a **structured, clear, and professional** introduction to your project. Let me know if you'd like any modifications! 🚀

