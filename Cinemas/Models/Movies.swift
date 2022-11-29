//
//  Cinemas.swift
//  Movies
//
//  Created by Tommy Yon Prakoso on 26/11/22.
//

import Foundation

struct Movies : Decodable {
    let page : Int
    let results : [Movie]
}

struct Movie : Decodable {
    let id : Int
    let adult : Bool
    let poster_path : String
    let original_language : String
    let overview : String
    let popularity : Float
    let release_date : String?
    let title : String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case adult = "adult"
        case poster_path = "poster_path"
        case original_language = "original_language"
        case overview = "overview"
        case popularity = "popularity"
        case release_date = "release_date"
        case title = "title"
    }
}
