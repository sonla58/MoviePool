//
//  File.swift
//  
//
//  Created by Anh Son Le on 13/03/2023.
//

import Foundation

public struct MovieResult: Codable {
    public let search: [Movie]
    public let totalResults, response: String
    public let error: String?
    
    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
        case error = "Error"
    }
}

extension MovieResult {
    public var isSuccess: Bool {
        return response == "True"
    }
}
