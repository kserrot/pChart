//
//  NoteDetail.swift
//  pChart
//
//  Created by Kaique Torres on 4/23/24.
//

import SwiftUI

struct NoteDetail: View {
    
    @Binding var note: NoteModel
    @StateObject var noteApp = NoteViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Patient ID", text: $note.patientID)
                .customTextFieldStyle()
            
            Text("Conditions")
                .font(.headline)
            TextEditor(text: $note.title)
                .frame(minHeight: 50) // minimum height for text editor
                .padding(4)
                .background(Color.gray.opacity(0.5)) // Slightly darker background
                .cornerRadius(5)

            // Multi-line text editor for notes
            Text("Notes")
                .font(.headline)
            TextEditor(text: $note.noteContent)
                .frame(minHeight: 50) // minimum height for text editor
                .padding(4)
                .background(Color.gray.opacity(0.5)) // Slightly darker background
                .cornerRadius(5)

            TextField("Created at: ", text: $note.createdAt)
                .customTextFieldStyle()
            TextField("Updated at: ", text: $note.updateAt)
                .customTextFieldStyle()
            TextField("Created by: ", text: $note.createdBy)
                .customTextFieldStyle()

            Button("Save") {
                Task {
                    await noteApp.saveData(note: note)
                    clearFields()
                }
            }
            .buttonStyle(.bordered)
            .controlSize(.regular)
            .background(Color.white)
            .foregroundColor(.blue)
            .cornerRadius(10)
        }
        .padding()
        .background(Color.accentColor.opacity(0.7)) // Background color for this view
        .navigationTitle("Edit Note")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Clear") { clearFields() }
                    .buttonStyle(.bordered)
                    .controlSize(.mini)
                    .background(Color.white)
                    .foregroundColor(.blue)
                    .cornerRadius(10)
            }
        }
    }
    
    private func clearFields() {
        note.patientID = ""
        note.title = ""
        note.noteContent = ""
        note.createdAt = ""
        note.updateAt = ""
        note.createdBy = ""
    }
}

extension View {
    func customTextFieldStyle() -> some View {
        self
            .font(.system(size: 20))
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            .background(Color.gray.opacity(0.7)) // Lighter background
    }
}

#Preview {
    NoteDetail(note:.constant(NoteModel(patientID: "", title: "", noteContent: "", createdAt: "", updateAt: "", createdBy: "")))
}
