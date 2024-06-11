//
//  MainModel.swift
//  TodoList
//
//  Created by Zaki on 11.06.2024.
//

import Foundation

enum MainModel {
	struct ViewData {
		let tasks: [Task]

		enum Task {
			case regularTask(RegularTask)
			case importantTask(ImportantTask)
		}
	
		struct RegularTask {
			let title: String
			let completed: Bool
		}
	
		struct ImportantTask {
			let title: String
			let completed: Bool
			let deadLine: String
			let priority: String
		}
	}
}
