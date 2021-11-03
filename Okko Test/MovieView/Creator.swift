//
//  Creator.swift
//  Okko Test
//
//  Created by Данила Бондаренко on 03.11.2021.
//

import Foundation


protocol CreatorProtocol {
    var view: MoviesViewProtocol? { get set }
    func correctData(movies: [Movie], id: Int)
}

final class Creator: CreatorProtocol {
    var view: MoviesViewProtocol?

    func correctData(movies: [Movie], id: Int) {
        var correctMovie = movies
        for i in 0..<correctMovie.count {
            correctMovie[i].genre = id
        }
        view?.moviesForGenreAdd(mov: correctMovie, id: id)
    }
}
