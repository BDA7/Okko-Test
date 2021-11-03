//
//  ErrorsTypes.swift
//  Okko Test
//
//  Created by Данила Бондаренко on 03.11.2021.
//

import Foundation
import UIKit


protocol ErrorsTypesProtocol {
    var view: UIViewController? { get set }
    func error(_ error: Error)
}

final class ErrorsTypes: ErrorsTypesProtocol {
    var view: UIViewController?

    
}
