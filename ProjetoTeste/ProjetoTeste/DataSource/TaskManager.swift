//
//  TaskManager.swift
//  ProjetoTeste
//

import Foundation
import CoreData
import UIKit

class TaskManager {

    private var tasks: [Task] = []
    
    let managedContext: NSManagedObjectContext = {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            return context
        }
        return NSManagedObjectContext()
    }()
    
    
    /// Adiciona uma nova tarefa na lista
    func addTask(title: String, description: String) {
        
        let taskEntity = TaskEntities(context: managedContext)
        
        taskEntity.title = title
        taskEntity.descriptions = description
        taskEntity.date = Date()
        
        do {
            try managedContext.save()
        } catch let error {
            print("Failed to create: \(error)")
        }
        
        let task = Task(fromManagedObject: taskEntity)
        tasks.append(task)
        
    }
    
    /// Informa a lista atual de tarefas
    func getTasks() -> [Task] {
        return tasks
    }
    
    /// Recupera as tarefas salvas
    func loadTasks() {
        fetchTasks()
    }
    
    // Edita uma tarefa de acordo com o indice no Array
    func editTask(withTitle oldTitle: String, title: String? = nil, description: String? = nil) {
        
        guard let entity = fetchTask(withTitle: oldTitle) else { return }
        
        if let title {
            entity.title = title
        }
        if let description {
            entity.descriptions = description
        }
        
        do {
            try managedContext.save()
        } catch let error {
            print("Failed to delete: \(error)")
        }

    }
    
    // Remove uma tarefa de acordo com o Indice no Array
    func deleteTask(index: Int) {
        
        guard let entity = fetchTask(withTitle: tasks[index].title) else { return }
        
        tasks.remove(at: index)

        managedContext.delete(entity)

        do {
            try managedContext.save()
        } catch let error {
            print("Failed to delete: \(error)")
        }
    }
    
    // Remove uma tarefa de acordo com o nome no Array
    func deleteTask(withTitle title: String) {
        
        guard let entity = fetchTask(withTitle: title) else { return }
        
        if let index = tasks.firstIndex(where: { $0.title == title }) {
            tasks.remove(at: index)
        }
        
        managedContext.delete(entity)

        do {
            try managedContext.save()
        } catch let error {
            print("Failed to delete: \(error)")
        }
    }
    
    func objectToEntity (task: Task) -> TaskEntities {
        let taskEntity = TaskEntities(context: managedContext)
        
        taskEntity.title = task.title
        taskEntity.descriptions = task.description
        taskEntity.date = task.createdAt
        
        return taskEntity
    }
    
    // Funções de Fetching usadas pra acessar o DataBase no Core Data
    func fetchTasks() {
        tasks.removeAll()
        
        let fetchRequest = NSFetchRequest<TaskEntities>(entityName: StringUtils.taskEntities)
        
        do {
            let taskEntities = try managedContext.fetch(fetchRequest)
            for taskEntity in taskEntities {
                let task = Task(fromManagedObject: taskEntity)
                tasks.append(task)
            }
        } catch let error {
            print("Failed to fetch companies: \(error)")
        }
    }
    
    func fetchTask(withTitle title: String) -> TaskEntities? {
        let fetchRequest = NSFetchRequest<TaskEntities>(entityName: StringUtils.taskEntities)
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)

        do {
            let taskEntity = try managedContext.fetch(fetchRequest)
            return taskEntity.first
        } catch let error {
            print("Failed to fetch: \(error)")
        }
        return nil
    }

}

struct Task: Codable {
    let title: String
    let description: String
    let createdAt: Date
}

extension Task {
    init(fromManagedObject managedObject: NSManagedObject) {
        self.title = managedObject.value(forKey: StringUtils.titleKey) as? String ?? ""
        self.description = managedObject.value(forKey: StringUtils.descriptionKey) as? String ?? ""
        self.createdAt = managedObject.value(forKey: StringUtils.dateKey) as? Date ?? Date()
    }
}

extension Task {
    init() {
        self.title = ""
        self.description = ""
        self.createdAt = Date()
    }
}
