//
//  MoviesController.swift
//  Okko Test
//
//  Created by Данила Бондаренко on 02.11.2021.
//

import Foundation


protocol MoviesControllerProtocol {
    var view: MoviesViewProtocol? { get set }
    var network: NetworkProtocol? { get set }
    var creator: CreatorProtocol? { get set }
    var router: RouterProtocol? { get set }

    func toMovies()
    func getMovies()
    func getGenres()
    func getNameOfGenres(id: Int) -> String
    func goToInfo(idMovie: Int)
}

final class MoviesController: MoviesControllerProtocol {
    var view: MoviesViewProtocol?
    var network: NetworkProtocol?
    var creator: CreatorProtocol?
    var router: RouterProtocol?

    var movieAr: [Movie] = [Movie]()
    var genres: [Genre] = [Genre]()

    fileprivate let urlGenres = "https://api.themoviedb.org/3/genre/movie/list?api_key=7cbed6f351107536df3dbed1e47b582e"
}

extension MoviesController {
//    func getGenres() {
//        network?.requestGenres(urlString: urlGenres, completion: { (results) in
//            switch results {
//
//            case .success(let request):
//                self.view?.setupSections(genres: request.genres)
//
//            case .failure(let error):
//                print("Error: \(error)")
//            }
//        })
//    }

    func getMovies() {
        network?.requestMovies(urlString: "https://api.themoviedb.org/3/movie/popular?api_key=7cbed6f351107536df3dbed1e47b582e", completion: { (results) in
            switch results {
                
            case .success(let request):
                self.movieAr = request.results
                self.view?.setupSections(genres: self.movieAr)
//                self.view?.addMovies(movies: request.results)

            case .failure(let error):
                print("Error: \(error)")
            }
        })
        view?.createDataSource()
    }

    func toMovies() {
        view?.addMovies(movies: movieAr)
    }

    func getNameOfGenres(id: Int) -> String {
        for i in genres {
            if i.id == id {
                return i.name
            }
        }
        return "NONE"
    }

    func getGenres() {
        network?.requestGenres(urlString: "https://api.themoviedb.org/3/genre/movie/list?api_key=7cbed6f351107536df3dbed1e47b582e", completion: { (result) in
            switch result {
                
            case .success(let request):
                self.genres = request.genres

                for genre in request.genres {
                    self.view?.createSect(id: genre.id)
                    self.getMoviesForGenre(id: genre.id)
                }
                self.view?.createDataSource()
                self.view?.setupHeaders()

            case .failure(let error):
                print("Error: \(error)")
            }
        })
    }

    func getMoviesForGenre(id: Int) {
        network?.requestMovies(urlString: "https://api.themoviedb.org/3/discover/movie?api_key=7cbed6f351107536df3dbed1e47b582e&with_genres=\(id)", completion: { (result) in
            switch result {
                
            case .success(let request):
                self.creator?.correctData(movies: request.results, id: id)
            case .failure(let error):
                print("Error: \(error)")
            }
        })
    }
}

extension MoviesController {
    func goToInfo(idMovie: Int) {
        router?.goToInfoView(id: idMovie)
    }
}
