//
//  ViewControllerConfigurator.swift
//  SPH-Tech-Test
//
//  Created by TA-002 on 22/05/20.
//  Copyright © 2020 Sarthak.org. All rights reserved.
//
import Foundation
extension ViewControllerPresenter: ViewControllerInteratorOutput {}
extension ViewControllerInterator: ViewControllerOutput {}
extension ViewController: ViewControllerPresenterOutput {}
final class ViewControllerConfigurator {
    static let sharedInstance = ViewControllerConfigurator()
    func configure(controller: ViewController) {
        let presenter = ViewControllerPresenter()
        presenter.output = controller
        let interactor = ViewControllerInterator()
        interactor.output = presenter
        controller.output = interactor
    }
}
