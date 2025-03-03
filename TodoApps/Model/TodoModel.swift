//
//  TodoModel.swift
//  TodoApps
//
//  Created by Prabhat on 3/1/25.
//

import Foundation
struct TodoModel: Encodable,Decodable{
    var id:String = UUID().uuidString
    let title:String
    var isDone:Bool = false
    let description:String
    
    func markAsCompleted() -> TodoModel{
        return TodoModel(title: title, isDone: true, description: description)
    }
}
