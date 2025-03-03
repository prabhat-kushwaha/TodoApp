//
//  TodoDetailsView.swift
//  TodoApps
//
//  Created by Prabhat on 3/1/25.
//

import SwiftUI

struct TodoDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel : TodoViewModel
    @State var isEditingDescription: Bool = false
    let todo:TodoModel
    
    var body: some View {
        NavigationStack{
            VStack{
                ScrollView{
                    Text(todo.description)
                        .frame(
                            maxWidth:.infinity,
                            alignment: .topLeading)
                        .font(.body)
                }
                
                Spacer()
                Button(action: {
                    isEditingDescription.toggle()
                }, label: {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundStyle(.primary)
                        .frame(width: 60 , height: 60)
                        .overlay {
                            Image(systemName: "pencil.and.scribble")
                                .foregroundStyle(.white)
                                .font(.title)
                        }
                    
                })
                .frame( maxWidth: .infinity,alignment:.trailing)
                
            }
            .padding()
            .navigationBarBackButtonHidden(true)
            .navigationTitle(todo.title)
            .toolbar {
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                    Image(systemName: "chevron.backward")
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                }
            }
            .popover(isPresented: $isEditingDescription) {
                CreateOrUpdateTodoView(todo: todo,isEdit: true)
            }
        }
    }
}

#Preview {
    TodoDetailsView(
        todo: TodoModel(title: "Gym", description: "Leg Day and some other task realated to gym and other stuff")
    )
}
