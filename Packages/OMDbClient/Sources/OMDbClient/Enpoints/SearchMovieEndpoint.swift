//
//  File.swift
//  
//
//  Created by Anh Son Le on 13/03/2023.
//

import Foundation

import BaseAPIClient

struct SearchMovieEndpoint {
    private let apiKey: String
    private let query: String
    private let type: MovieType?
    private let yearOfRelease: String?
    private let page: Int?
    
    init(apiKey: String,
         query: String,
         type: MovieType? = nil,
         yearOfRelease: String? = nil,
         page: Int? = nil) {
        self.apiKey = apiKey
        self.query = query
        self.type = type
        self.yearOfRelease = yearOfRelease
        self.page = page
    }
}

extension SearchMovieEndpoint: OMDbEnpointProtocol {
    var queryParams: APIParameterCompatible? {
        var params = [
            KeyAnyValue(key: "apikey", value: apiKey),
            KeyAnyValue(key: "s", value: query)
        ]
        if let type {
            params.append(KeyAnyValue(key: "type", value: type))
        }
        if let yearOfRelease {
            params.append(KeyAnyValue(key: "y", value: yearOfRelease))
        }
        if let page {
            params.append(KeyAnyValue(key: "page", value: page))
        }
        return params
    }
    
    var path: String {
        ""
    }
    var method: HTTPMethod {
        .get
    }
}
