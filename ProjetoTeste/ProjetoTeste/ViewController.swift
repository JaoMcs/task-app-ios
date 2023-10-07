//
//  ViewController.swift
//  ProjetoTeste
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    /// Tabela que exibe as tarefas existentes
    @IBOutlet weak var tableView: UITableView!

    /// Gerenciador de tarefas
    let taskManager = TaskManager()
    
    private let titleKey = "title"

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self

//        taskManager.loadTasks()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        taskManager.loadTasks() // Possivel erro aqui !!!!!
        tableView.reloadData()
    }
    
    @IBAction func addTaskAction(_ sender: Any) {
        let vm = AddTaskViewModel(taskManager: taskManager,
                                  reloadData: { _ in 
            self.tableView.reloadData()
        })
        let addTaskView = AddTaskView(viewModel: vm)
        let addTaskViewHostingController = UIHostingController(rootView: addTaskView)
        present(addTaskViewHostingController, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskManager.getTasks().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskTableViewCell
        let task = taskManager.getTasks()[indexPath.row]
        cell.titleLabel.text = task.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        taskManager.deleteTask(index: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        tableView.endUpdates()
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "taskDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailsVC = segue.destination as! DetailsViewController
        guard let indexPath = tableView.indexPathForSelectedRow else { return }

        let task = taskManager.getTasks()[indexPath.row]
        let vm = DetailsViewModel(task: task,
                                  taskManager: taskManager)
        
        detailsVC.config(viewModel: vm)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
