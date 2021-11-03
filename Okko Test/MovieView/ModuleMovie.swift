//
//  ModuleMovie.swift
//  Okko Test
//
//  Created by Данила Бондаренко on 02.11.2021.
//

import Foundation

final class ModuleMovie {
    static func build() -> MoviesViewController {
        let view = MoviesViewController()
        let controller = MoviesController()
        let network = Network()
        let creator = Creator()
        let router = Router()

        view.controller = controller
        controller.view = view
        controller.network = network
        controller.creator = creator
        controller.router = router
        creator.view = view
        router.transitionHandler = view

        return view
    }
}
