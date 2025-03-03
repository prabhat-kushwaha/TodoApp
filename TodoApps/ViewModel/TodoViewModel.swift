//
//  TodoViewModel.swift
//  TodoApps
//
//  Created by Prabhat on 3/1/25.
//

import Foundation

class TodoViewModel : ObservableObject {
    static let shared = TodoViewModel()
    @Published var todoList : [TodoModel] = []{
        didSet {
            saveData()
        }
    }
    let pref:String = "todoList"
    
    init() {
        guard
            let strTodo = UserDefaults.standard.data(forKey: pref),
            let todoList = try? JSONDecoder().decode([TodoModel].self, from: strTodo)
        else {
            return
        }
        self.todoList = todoList
    }
    
    func addTodo(todo:TodoModel){
        todoList.append(todo)
    }
    
    func deleteTodo(id:String){
        let index  = todoList.firstIndex(where: {$0.id == id})
        guard let index else  {
            return
        }
        todoList.remove(at: index)
        
    }
    func updateTodo(id:String){
        let index  = todoList.firstIndex(where: {$0.id == id})
        guard let index else  {
            return
        }
        todoList[index] = todoList[index].markAsCompleted()
    }
    
    func updateTodoContent(id:String,desc:String){
        let index  = todoList.firstIndex(where: {$0.id == id})
        guard let index else  {
            return
        }
        let todo = todoList[index]
        todoList[index] = TodoModel(id: todo.id, title: todo.title, isDone:todo.isDone, description: desc)
    }
    
    func saveData(){
        if let strTodo = try? JSONEncoder().encode(todoList){
            UserDefaults.standard.set(strTodo, forKey: pref)
        }
        
    }
    
}
