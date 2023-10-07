//
//  DetailsViewController.swift
//  ProjetoTeste
//
//  Created by João Marcos on 06/10/23.
//

import UIKit
import SwiftUI

class DetailsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    
    var viewModel: DetailsViewModel
    
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    func config(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        viewModel = DetailsViewModel()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
    }

    
    func setupData() {
        titleLabel.text = viewModel.task.title
        descriptionLabel.text = viewModel.task.description
        dataLabel.text = StringUtils.dataFormater(data: viewModel.task.createdAt)
    }
    
    @IBAction func editAction(_ sender: Any) {
        let vm = AddTaskViewModel(title: viewModel.task.title,
                                  description: viewModel.task.description,
                                  taskManager: viewModel.taskManager,
                                  reloadData: { [self] task in
            if let task {
                self.viewModel.task = task
                self.setupData()
            } else {
                backAction(self)
            }
        },
                                  isEditTask: true)

        let addTaskView = AddTaskView(viewModel: vm)
        let addTaskViewHostingController = UIHostingController(rootView: addTaskView)
        present(addTaskViewHostingController, animated: true)

    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
