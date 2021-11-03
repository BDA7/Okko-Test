//
//  Router.swift
//  Okko Test
//
//  Created by Данила Бондаренко on 03.11.2021.
//

import Foundation
import UIKit


protocol RouterProtocol {
    var transitionHandler: UIViewController? { get set }
    func goToInfoView(id: Int)
    func error(_ error: Error)
}

final class Router: RouterProtocol {
    var transitionHandler: UIViewController?
}

//MARK: - Jump to InfoMovieView
extension Router {
    func goToInfoView(id: Int) {
        let info = InfoModule.build(id: id)
        transitionHandler?.navigationController?.pushViewController(info, animated: true)
    }

    func error(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Work", style: .default, handler: nil))
        self.transitionHandler?.present(alert, animated: true, completion: nil)
    }
}

