//
//  MainViewController.swift

import UIKit
import TaskManagerPackage

protocol IMainViewController: AnyObject {
	func render(viewData: MainModel.ViewData)
}

final class MainViewController: UITableViewController {

	var presenter: IMainPresenter?

	private var viewData = MainModel.ViewData(tasks: [])

	init() {
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		title = "TodoList"
		setup()
		presenter?.viewIsReady()
	}
}

extension MainViewController {
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewData.tasks.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let task = viewData.tasks[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		configureCell(cell, with: task)
		return cell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		presenter?.didTaskSelected(at: indexPath)
	}
}

private extension MainViewController {

	private func setup() {
		self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
	}

	func getTaskForIndex(_ indexPath: IndexPath) -> MainModel.ViewData.Task {
		viewData.tasks[indexPath.row]
	}

	func configureCell(_ cell: UITableViewCell, with task: MainModel.ViewData.Task) {
		var contentConfiguration = cell.defaultContentConfiguration()

		switch task {
		case .regularTask(let task):
			contentConfiguration.text = task.title
			cell.accessoryType = task.completed ? .checkmark : .none

		case .importantTask(let task):
			let redText = [NSAttributedString.Key.foregroundColor: UIColor.red]
			let taskText = NSMutableAttributedString(string: task.priority + " ", attributes: redText)
			taskText.append(NSAttributedString(string: task.title))
			contentConfiguration.attributedText = taskText
			contentConfiguration.secondaryText = task.deadLine
			cell.accessoryType = task.completed ? .checkmark : .none
		}

		cell.contentConfiguration = contentConfiguration
	}
}

extension MainViewController: IMainViewController {
	func render(viewData: MainModel.ViewData) {
		self.viewData = viewData
		tableView.reloadData()
	}
}
