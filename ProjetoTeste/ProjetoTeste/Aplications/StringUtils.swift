//
//  StringUtils.swift
//  ProjetoTeste
//
//  Created by João Marcos on 07/10/23.
//

import Foundation

struct StringUtils {
    
    
    //MARK: - Keys and Identifiers
    static let identifierTaskCell = "TaskCell"
    static let identifierTaskDetails = "taskDetails"
    static let taskEntities = "TaskEntities"
    static let titleKey = "title"
    static let descriptionKey = "descriptions"
    static let dateKey = "date"
    
    
    //MARK: - Strings using in code
    static let title = "Título"
    static let description = "Descrição"
    static let navigationTitleNewTaks = "Nova Tarefa"
    static let cancel = "Cancelar"
    static let ok = "OK"
    static let add = "Adicionar"
    
    
    //MARK: - Image and Asset strings
    static let imageSystemNameTrash = "trash"
    static let accentColor = "AccentColor"
    static let titleColor = "TitleColor"
    
    static func dataFormater(data: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dataString = dateFormatter.string(from: data)
        return dataString
    }
}
