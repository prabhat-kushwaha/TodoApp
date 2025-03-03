//
//  TodoList.swift
//  TodoApps
//
//  Created by Prabhat on 3/1/25.
//

import SwiftUI

struct TodoList: View {
    
    @EnvironmentObject var viewModel : TodoViewModel
    @State var isPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.todoList.isEmpty {
                    ContentUnavailableView("Nothing here yet! Add your first to-do.",systemImage: "folder.fill")
                }else{ ShowTodos }
                
                Button(action: {
                    isPresented.toggle()
                }, label: {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundStyle(.primary)
                        .frame(width: 60 , height: 60)
                        .overlay {
                            Image(systemName: "plus").foregroundStyle(.white).font(.title)
                        }
                    
                })
                .frame( maxWidth: .infinity,alignment:.trailing)
                .padding()
                .navigationTitle(Text("Your Todo 📝"))
                .popover(isPresented: $isPresented) {
                    CreateOrUpdateTodoView(todo: nil,isEdit: false)
                }
            }
        }
    }
    
    var ShowTodos: some View {
        List {
            ForEach(viewModel.todoList,id: \.id) { todo in
                NavigationLink {
                    TodoDetailsView(todo: todo)
                } label: {
                    TodoRowView(todo: todo)
                }
                
                .swipeActions(edge: .trailing,allowsFullSwipe: false) {
                    Button(action: {
                        viewModel.deleteTodo(id:todo.id)
                    }) {
                        Image(systemName: "trash")
                    }.tint(.red)
                }
                
            }
            
        }
        .listStyle(.plain)
    }
}

#Preview {
    TodoList().environmentObject(TodoViewModel())
}

