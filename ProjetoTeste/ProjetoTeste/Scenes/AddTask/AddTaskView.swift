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
            VStack {
                List {
                    TextField(StringUtils.title, text: $viewModel.title, axis: .vertical)
                    TextField(StringUtils.description, text: $viewModel.description, axis: .vertical)
                        .frame(minHeight: 150, alignment: .top)

                }
                if viewModel.isEditTask {
                    Button(action: {
                        viewModel.remove()
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: StringUtils.imageSystemNameTrash)
                            .font(.largeTitle)
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle(StringUtils.navigationTitleNewTaks)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color(StringUtils.accentColor), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(viewModel.addOrEdit) {
                        viewModel.addItem()
                        self.presentationMode.wrappedValue.dismiss()
                    }.tint(Color(StringUtils.titleColor))
                        .disabled(viewModel.title.isEmpty || viewModel.description.isEmpty)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button(viewModel.cancelarString) {
                        viewModel.cancel()
                        self.presentationMode.wrappedValue.dismiss()
                    }.tint(Color(StringUtils.titleColor))
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
