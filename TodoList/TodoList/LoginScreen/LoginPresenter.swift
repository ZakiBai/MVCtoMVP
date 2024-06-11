//
//  LoginPresenter.swift
//  TodoList
//
//  Created by Zaki on 11.06.2024.
//

import UIKit

protocol ILoginPresenter {
	func viewIsReady()
	func didLogin(login: String, password: String)
}

class LoginPresenter: ILoginPresenter {

	private weak var view: ILoginViewController!
	private let nextScreen: UIViewController!

	init(view: ILoginViewController!, nextScreen: UIViewController!) {
		self.view = view
		self.nextScreen = nextScreen
	}

	func viewIsReady() {
		view.render(viewData: LoginModel.ViewData(login: "", password: ""))
	}

	func didLogin(login: String, password: String) {
		view.show(screen: nextScreen)
	}
}
