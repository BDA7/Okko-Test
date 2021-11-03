//
//  Network.swift
//  Okko Test
//
//  Created by Данила Бондаренко on 02.11.2021.
//

import Foundation
import UIKit


protocol NetworkProtocol {
    func requestGenres(urlString: String, completion: @escaping (Result<GenresModel, Error>) -> Void)

    func requestMovies(urlString: String, completion: @escaping (Result<MoviesModel, Error>) -> Void)

    func getMovieDeitals(urlString: String, completion: @escaping (Result<Movie, Error>) -> Void)
}

//MARK: - work for tmdb
final class Network: NetworkProtocol {
// get genres
    func requestGenres(urlString: String, completion: @escaping (Result<GenresModel, Error>) -> Void) {

        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { (data, _, error) in
            DispatchQueue.main.async {

                if let error = error {
                    print("Error")
                    completion(.failure(error))
                    return
                }

                guard let data = data else { return }

                do {
                    let characters = try JSONDecoder().decode(GenresModel.self, from: data)
                    completion(.success(characters))
                } catch  let jsonError {
                    print("Faled Decode \(jsonError)")
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }
// get movies
    func requestMovies(urlString: String, completion: @escaping (Result<MoviesModel, Error>) -> Void) {

        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { (data, _, error) in

            DispatchQueue.main.async {

                if let error = error {
                    print("Error")
                    completion(.failure(error))
                    return
                }

                guard let data = data else { return }

                do {
                    let characters = try JSONDecoder().decode(MoviesModel.self, from: data)
                    completion(.success(characters))
                } catch  let jsonError {
                    print("Faled Decode \(jsonError)")
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }
// Get movie Deitals
    func getMovieDeitals(urlString: String, completion: @escaping (Result<Movie, Error>) -> Void) {
        
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { (data, _, error) in
            DispatchQueue.main.async {

                if let error = error {
                    print("Error")
                    completion(.failure(error))
                    return
                }

                guard let data = data else { return }

                do {
                    let characters = try JSONDecoder().decode(Movie.self, from: data)
                    completion(.success(characters))
                } catch  let jsonError {
                    print("Faled Decode \(jsonError)")
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }
}

//MARK: - load image for movie
extension UIImageView {
    func load(link: String?) {
        if link != " ", link != nil {
            guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(link!)" ) else { return }
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.image = image
                        }
                    }
                }
            }
        } else {
            self.image = UIImage(named: "nullImage")
        }
    }
}
