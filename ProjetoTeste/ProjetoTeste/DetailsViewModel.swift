//
//  DetailsViewModel.swift
//  ProjetoTeste
//
//  Created by João Marcos on 06/10/23.
//

import Foundation
import SwiftUI

class DetailsViewModel {
    
    var task: Task
    let taskManager: TaskManager
    
    init(task: Task = Task(),
         taskManager: TaskManager = TaskManager()) {
        self.task = task
        self.taskManager = taskManager
    }
    
}
