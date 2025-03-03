//
//  CreateTodoView.swift
//  TodoApps
//
//  Created by Prabhat on 3/1/25.
//

import SwiftUI

struct CreateOrUpdateTodoView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel : TodoViewModel
    @State var todoText: String = ""
    @State var todoDesc: String = ""
    @State var showError: Bool = false
    let todo: TodoModel?
    let isEdit: Bool
    var body: some View {
        NavigationStack{
            VStack{
                KTextField(text: $todoText, title: "Title",placeHolder: "Enter Todo Title",isDisabled: isEdit)
                
                KTextField(text: $todoDesc, title: "Description",placeHolder: "Enter Todo Description")
                Spacer()
                Button {
                    if validateInput(){
                        if isEdit{
                            if let id = todo?.id{
                                viewModel.updateTodoContent(id:id, desc: todoDesc )
                            }
                           
                        }else{
                            viewModel.addTodo(todo: TodoModel(title: todoText, description: todoDesc))
                        }
                       
                        presentationMode.wrappedValue.dismiss()
                    }else{
                        showError.toggle()
                    }
                } label: {
                    Text(isEdit ? "Update" : "Create")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.accent)
                        .cornerRadius(12)
                }
                
            }
            .padding()
            .navigationTitle(isEdit ? "Edit Todo" : "Create Todo")
            .toolbar {
                ToolbarItem(content: {
                    Text("Cancel")
                        .fontWeight(.semibold)
                        .foregroundColor(.accent)
                        .onTapGesture {presentationMode.wrappedValue.dismiss()}
                })
            }
            .alert("Please enter title to create todo", isPresented: $showError) {
                
            }
        }.onAppear(){
            loadInitData()
        }
        
    }
    func loadInitData(){
        if let todo = todo{
            todoText = todo.title
            todoDesc = todo.description
        }
    }
    
    func validateInput() -> Bool {
        return !todoDesc.isEmpty && !todoText.isEmpty
    }
}

struct KTextField: View {
    @Binding var text: String
    var title: String
    var placeHolder: String
    var isDisabled: Bool = false
    var body: some View {
        VStack(alignment:.leading){
            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .fontDesign(.rounded)
                .foregroundStyle(.gray)
            
            TextField(placeHolder, text:$text).disabled(isDisabled)
            Divider()
        }
        
    }
}

#Preview {
    CreateOrUpdateTodoView(todo: nil, isEdit: false)
}
