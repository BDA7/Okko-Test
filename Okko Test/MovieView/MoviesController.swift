//
//  MoviesController.swift
//  Okko Test
//
//  Created by Данила Бондаренко on 02.11.2021.
//

import Foundation


//Actions
enum MoviesControllerAction {
    case getGenres
    case getNameOfGenres(id: Int)
    case goToInfo(idMovie: Int)
}

protocol MoviesControllerProtocol {
    var view: MoviesViewProtocol? { get set }
    var network: NetworkProtocol? { get set }
    var creator: CreatorProtocol? { get set }
    var router: RouterProtocol? { get set }
    

    func action(with: MoviesControllerAction)
    func getGenres()
    func getNameOfGenres(id: Int)
    func goToInfo(idMovie: Int)
}

final class MoviesController: MoviesControllerProtocol {
    var view: MoviesViewProtocol?
    var network: NetworkProtocol?
    var creator: CreatorProtocol?
    var router: RouterProtocol?

    var genres: [Genre] = [Genre]()

    fileprivate let urlGenres = "https://api.themoviedb.org/3/genre/movie/list?api_key=7cbed6f351107536df3dbed1e47b582e"
    fileprivate let urlMovies = "https://api.themoviedb.org/3/discover/movie?api_key=7cbed6f351107536df3dbed1e47b582e&with_genres="

    func action(with: MoviesControllerAction) {
        switch with {
        case .getGenres:
            getGenres()
        case .getNameOfGenres(let id):
            getNameOfGenres(id: id)
        case .goToInfo(let idMovie):
            goToInfo(idMovie: idMovie)
        }
    }
}

//MARK: - Get Movies and Genres for MoviesView
extension MoviesController {

    func getNameOfGenres(id: Int) {
        creator?.action(with: .getNameOfGenres(genres: self.genres, id: id))
    }

    func getGenres() {
        network?.requestGenres(urlString: urlGenres, completion: { (result) in
            switch result {
                
            case .success(let request):
                self.genres = request.genres

                for genre in request.genres {
                    self.view?.action(with: .createSect(id: genre.id))
                    self.getMoviesForGenre(id: genre.id)
                }
                self.view?.action(with: .createDataSource)
                self.view?.action(with: .setupHeaders)

            case .failure(let error):
                self.router?.error(error)
            }
        })
    }

    func getMoviesForGenre(id: Int) {
        network?.requestMovies(urlString: urlMovies + "\(id)", completion: { (result) in
            switch result {
                
            case .success(let request):
                self.creator?.action(with: .correctData(movies: request.results, id: id))
            case .failure(let error):
                self.router?.error(error)
            }
        })
    }
}

extension MoviesController {
    func goToInfo(idMovie: Int) {
        router?.goToInfoView(id: idMovie)
    }
}
