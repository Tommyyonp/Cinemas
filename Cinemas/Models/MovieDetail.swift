//
//  MovieDetail.swift
//  Cinemas
//
//  Created by Tommy Yon Prakoso on 26/11/22.
//

import Foundation

struct MovieDetail : Decodable {
    let id : Int
    let adult : Bool
    let poster_path : String
    let original_language : String
    let overview : String
    let popularity : Float
    let release_date : String
    let title : String
    let backdrop_path : String
    let homepage : String
    let genres : [Genres]
    let tagline : String
    let vote_average : Float
    let vote_count : Int}

struct Genres : Decodable {
    let id : Int
    let name : String
}

struct MovieLink : Decodable {
    let id: Int
    let results: [Result]
}
    
struct Result: Decodable {
    let iso639_1, iso3166_1, name, key: String
    let site: String
    let size: Int
    let type: String
    let official: Bool
    let publishedAt, id: String

    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case name, key, site, size, type, official
        case publishedAt = "published_at"
        case id
    }
}

struct MovieReview: Decodable {
    let id, page: Int
    let results: [Review]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case id, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Review: Codable {
    let author: String
    let authorDetails: AuthorDetails
    let content, createdAt, id, updatedAt: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case author
        case authorDetails = "author_details"
        case content
        case createdAt = "created_at"
        case id
        case updatedAt = "updated_at"
        case url
    }
}

struct AuthorDetails: Codable {
    let name, username: String
    let avatarPath: String?
    let rating: Int?

    enum CodingKeys: String, CodingKey {
        case name, username
        case avatarPath = "avatar_path"
        case rating
    }
}
