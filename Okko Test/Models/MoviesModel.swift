//
//  MoviesModel.swift
//  Okko Test
//
//  Created by Данила Бондаренко on 02.11.2021.
//

import Foundation


//MARK: - Model Movies
struct MoviesModel: Decodable, Hashable {
    var page: Int
    var results: [Movie]
}

struct Movie: Decodable, Hashable {
    var id: Int
    var genre_ids: [Int]?
    var original_language: String
    var original_title: String
    var overview: String
    var popularity: Double
    var poster_path: String
    var release_date: String
    var vote_average: Double
    var genre: Int?
}
