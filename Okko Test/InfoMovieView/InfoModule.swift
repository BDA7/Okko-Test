//
//  InfoModule.swift
//  Okko Test
//
//  Created by Данила Бондаренко on 03.11.2021.
//

import Foundation


final class InfoModule {
    static func build(id: Int) -> InfoViewController {
        let view = InfoViewController()
        view.id = id
        let controller = InfoController()
        let network = Network()

        controller.view = view
        controller.network = network
        view.controller = controller

        return view
    }
}
