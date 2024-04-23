//
//  NoteViewModel.swift
//  pChart
//
//  Created by Kaique Torres on 4/23/24.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

class NoteViewModel : ObservableObject {
    
    @Published var patientNotes = [NoteModel]()
    let db = Firestore.firestore()
    
    //Fetch the charts 
    func fetchData() async {
            do {
                let querySnapshot = try await db.collection("patientNotes").getDocuments()
                DispatchQueue.main.async { [weak self] in
                    self?.patientNotes = querySnapshot.documents.compactMap { document in
                        try? document.data(as: NoteModel.self)
                    }
                }
            } catch {
                print("Error getting documents: \(error)")
            }
    }
    
    //Save the new Charts
    func saveData(note: NoteModel) async{
        
        if let id = note.id{
            let washingtonRef = db.collection("patientNotes").document(id)
            do {
              try await washingtonRef.updateData([
                "patientID": note.patientID,
                "title": note.title,
                "noteContent" : note.noteContent,
                "createdAt": note.createdAt,
                "updateAt": note.updateAt,
                "createdBy": note.createdBy
              ])
                await fetchData()
              print("Document successfully updated")
            } catch {
              print("Error updating document: \(error)")
            }
        } else {
            if !note.patientID.isEmpty || !note.title.isEmpty || !note.noteContent.isEmpty || !note.createdAt.isEmpty || !note.updateAt.isEmpty || !note.createdBy.isEmpty {
                do {
                    let ref = try await db.collection("patientNotes").addDocument(data: [
                        "patientID": note.patientID,
                        "title": note.title,
                        "noteContent" : note.noteContent,
                        "createdAt": note.createdAt,
                        "updateAt": note.updateAt,
                        "createdBy": note.createdBy
                    ])
                    print("Document added with ID: \(ref.documentID)")
                } catch {
                    print("Error adding document: \(error)")
                }
            }
        }
    }
}
