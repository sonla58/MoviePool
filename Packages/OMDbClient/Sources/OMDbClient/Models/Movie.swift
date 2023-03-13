//
//  File.swift
//  
//
//  Created by Anh Son Le on 13/03/2023.
//

import Foundation

public struct Movie: Codable {
    public let title, year, imdbID: String
    public let type: MovieType
    public let poster: String
    
    public init(title: String, year: String, imdbID: String, type: MovieType, poster: String) {
        self.title = title
        self.year = year
        self.imdbID = imdbID
        self.type = type
        self.poster = poster
    }
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}

public enum MovieType: String, Codable {
    case movie = "movie"
    case series = "series"
    case episode = "episode"
}
