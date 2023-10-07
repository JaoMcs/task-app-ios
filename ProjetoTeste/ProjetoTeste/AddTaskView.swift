//
//  AddTaskView.swift
//  ProjetoTeste
//
//  Created by João Marcos on 06/10/23.
//

import SwiftUI

struct AddTaskView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    
    @ObservedObject var viewModel: AddTaskViewModel
    
    var body: some View {
        NavigationView {
            List {
                TextField("Título", text: $viewModel.title, axis: .vertical)
                TextField("Descrição", text: $viewModel.description, axis: .vertical)
                    .frame(minHeight: 150, alignment: .top)

            }
            .navigationTitle("Nova Tarefa")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color("AccentColor"), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(viewModel.addOrEdit) {
                        viewModel.addItem()
                        self.presentationMode.wrappedValue.dismiss()
                    }.tint(Color("TitleColor"))
                        .disabled(viewModel.title.isEmpty || viewModel.description.isEmpty)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button(viewModel.cancelarString) {
                        viewModel.cancel()
                        self.presentationMode.wrappedValue.dismiss()
                    }.tint(Color("TitleColor"))
                }
            }
        }
        
    }
}



struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView(viewModel: AddTaskViewModel(taskManager: TaskManager(), reloadData: { _ in 
            print("TESTE")
        }))
    }
}
