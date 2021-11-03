//
//  ViewModel.swift
//  Okko Test
//
//  Created by Данила Бондаренко on 03.11.2021.
//

import Foundation


enum ViewModelActions {
    case setSection(new: [Int])
    case updateGenres(new: [Genre])
    case updateMovies(new: [Movie])
    case addNewSection(id: Int)
}

protocol ViewModelProtocol {
    func action(with: ViewModelActions)
    func getGenres() -> [Genre]
    func getSections() -> [Int]
    func getMovies() -> [Movie]
    
}

final class ViewModel: ViewModelProtocol {
    var sections: [Int] = [Int]()
    var genres: [Genre] = [Genre]()
    var movies: [Movie] = [Movie]()

    func action(with: ViewModelActions) {
        switch with {
        case .setSection(let new):
            setSection(new: new)

        case .updateGenres(let new):
            updateGenres(new: new)

        case .updateMovies(let new):
            updateMovies(new: new)

        case .addNewSection(let id):
            addNewSection(id: id)
        }
    }

    func updateGenres(new: [Genre]) {
        self.genres = new
    }

    func getGenres() -> [Genre] {
        return self.genres
    }

    func updateMovies(new: [Movie]) {
        self.movies = new
    }

    func getMovies() -> [Movie] {
        return self.movies
    }

    func setSection(new: [Int]) {
        self.sections = new
    }

    func getSections() -> [Int] {
        return self.sections
    }

    func addNewSection(id: Int) {
        self.sections.append(id)
    }
}
