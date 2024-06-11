//
//  MainPresenter.swift
//  TodoList
//
//  Created by Zaki on 11.06.2024.
//

import Foundation
import TaskManagerPackage

protocol IMainPresenter: AnyObject {
	func viewIsReady()
	func didTaskSelected(at indexPath: IndexPath)
}

class MainPresenter: IMainPresenter {

	private var taskManager: ITaskManager
	private weak var view: IMainViewController!

	init(taskManager: ITaskManager, view: IMainViewController!) {
		self.taskManager = taskManager
		self.view = view
	}

	func didTaskSelected(at indexPath: IndexPath) {
		let task = taskManager.allTasks()[indexPath.row]
		task.completed.toggle()
		view.render(viewData: mapViewData())
	}

	func viewIsReady() {
		view.render(viewData: mapViewData())
	}

	private func mapViewData() -> MainModel.ViewData {
		let tasks = taskManager.allTasks().map { mapTaskData(task: $0) }
		return MainModel.ViewData(tasks: tasks)
	}

	private func mapTaskData(task: Task) -> MainModel.ViewData.Task {
		if let task = task as? ImportantTask {
			let reuslt = MainModel.ViewData.ImportantTask(
				title: task.title,
				completed: task.completed,
				deadLine: "Deadline: \(task.deadLine)",
				priority: "\(task.taskPriority)"
			)
			return .importantTask(reuslt)
		} else {
			return .regularTask(MainModel.ViewData.RegularTask(
				title: task.title,
				completed: task.completed
			))
		}
	}
}
