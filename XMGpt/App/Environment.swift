//
//  Environment.swift
//  XMGpt
//
//  Created by RightMac-Rene on 31/03/2025.
//

import Foundation

/**
 *`Environment` is a utility to manage app-wide configuration values.
 * Centralized place to store and retrieve sensitive configuration values. Prevents hardcoding API keys directly in the source code for security reasons.
 */
public enum Environment {
    /**
     * `Keys` holds the keys used to access values stored in the `Info.plist` file.
     */
    enum Keys {
        static let apiKey = "GEMINI_API_KEY"
    }
    
    /**
     * The app's `Info.plist` dictionary, loaded from the app bundle.
     * This dictionary contains configuration values set in `Info.plist`.
     * If the dictionary is missing, the app will crash with a fatal error.
     */
    private static let infoDictionary: [String: Any] = {
        guard let dictionary = Bundle.main.infoDictionary else {
            fatalError("Failed to load Info.plist")
        }
        return dictionary
    }()
    
    /**
     * Retrieves the Gemini API key from `Info.plist`.
     * If the API key is missing or incorrectly set, the app will crash with a fatal error.
     */
    static var apiKey: String = {
        guard let apiKey = infoDictionary[Keys.apiKey] as? String else {
            fatalError("Missing API key in Info.plist")
        }
        return apiKey
    }()
}
