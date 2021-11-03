//
//  GenresModel.swift
//  Okko Test
//
//  Created by Данила Бондаренко on 02.11.2021.
//

import Foundation


//MARK: - Model Genres
struct GenresModel: Decodable, Hashable {
    var genres: [Genre]
}

struct Genre: Decodable, Hashable {
    var id: Int
    var name: String
}
