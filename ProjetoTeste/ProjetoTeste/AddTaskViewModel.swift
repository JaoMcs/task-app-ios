//
//  AddTaskViewModel.swift
//  ProjetoTeste
//
//  Created by João Marcos on 06/10/23.
//

import Foundation

class AddTaskViewModel: ObservableObject {
    
    @Published var title: String = ""
    @Published var description: String = ""
    
    var addOrEdit: String
    let cancelarString = "Cancelar"
    
    var isEditTask: Bool
    var oldTitle: String
    
    
    let reloadData: ((_ task: Task?) -> Void)?
    let taskManager: TaskManager

    
    init(title: String = "", description: String = "",
         taskManager: TaskManager,
         reloadData: ((_ task: Task?) -> Void)?,
         isEditTask: Bool = false) {
        
        self.title = title
        self.description = description
        self.oldTitle = title
        
        
        self.reloadData = reloadData
        self.taskManager = taskManager
        self.isEditTask = isEditTask
    
        if isEditTask {
            addOrEdit = "Editar"
        } else {
            addOrEdit = "Adicionar"
        }
    }
    
    // Função para cancelar e fechar a tela
    func cancel() {
        title = ""
        description = ""
        // Pensar em algo
    }
    
    func addItem() {
        if isEditTask {
            taskManager.editTask(withTitle: oldTitle, title: title, description: description)
            let task = Task(title: title, description: description, createdAt: Date())
            reloadData?(task)
        } else {
            taskManager.addTask(title: title, description: description)
            reloadData?(nil)
        }

    }
}
