//
//  Creator.swift
//  Okko Test
//
//  Created by Данила Бондаренко on 03.11.2021.
//

import Foundation


//Actions
enum CreatorAction {
    case correctData(movies: [Movie], id: Int)
    case getNameOfGenres(genres: [Genre], id: Int)
}

protocol CreatorProtocol {
    var view: MoviesViewProtocol? { get set }
    func action(with: CreatorAction)
}

final class Creator: CreatorProtocol {
    var view: MoviesViewProtocol?

    func action(with: CreatorAction) {
        switch with {
        case .correctData(let movies, let id):
            correctData(movies: movies, id: id)
        case .getNameOfGenres(let genres, let id):
            getNameOfGenres(genres: genres, id: id)
        }
    }
}

//MARK: - Corresct MoviesModel and get name Of Genre
extension Creator {
    func correctData(movies: [Movie], id: Int) {
        var correctMovie = movies
        for i in 0..<correctMovie.count {
            correctMovie[i].genre = id
        }
        view?.action(with: .moviesForGenreAdd(mov: correctMovie, id: id))
    }

    func getNameOfGenres(genres: [Genre], id: Int) {
        for i in genres {
            if i.id == id {
                view?.action(with: .updateTitleHeader(newTitle: i.name))
                return
            }
        }
    }
}
