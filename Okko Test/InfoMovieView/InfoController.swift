//
//  InfoController.swift
//  Okko Test
//
//  Created by Данила Бондаренко on 03.11.2021.
//

import Foundation


protocol InfoControllerProtocol {
    var view: InfoViewProtocol? { get set }
    var network: NetworkProtocol? { get set }

    func getMovieDeitals(id: Int)
}

final class InfoController: InfoControllerProtocol {
    var view: InfoViewProtocol?
    var network: NetworkProtocol?
}

extension InfoController {
    func getMovieDeitals(id: Int) {
        network?.getMovieDeitals(urlString: "https://api.themoviedb.org/3/movie/\(id)?api_key=7cbed6f351107536df3dbed1e47b582e", completion: { (results) in
            switch results {
                
            case .success(let request):
                self.view?.configure(movie: request)
            case .failure(let error):
                print("Error: \(error)")
            }
        })
    }
}
