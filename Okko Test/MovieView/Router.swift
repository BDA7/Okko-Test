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
}

final class Router: RouterProtocol {
    var transitionHandler: UIViewController?
}

extension Router {
    func goToInfoView(id: Int) {
        let info = InfoModule.build(id: id)
        transitionHandler?.navigationController?.pushViewController(info, animated: true)
    }
}

