//
//  TodoRowView.swift
//  TodoApps
//
//  Created by Prabhat on 3/1/25.
//

import SwiftUI

struct TodoRowView: View {
    let todo:TodoModel
    var body: some View {
        HStack {
            Text(todo.title)
            Spacer()
        }
    }
}

#Preview(traits:.sizeThatFitsLayout){
    TodoRowView(todo:TodoModel(title: "Home Work", description: "Science Home Work"))
}
