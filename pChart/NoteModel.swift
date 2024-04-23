//
//  NoteModel.swift
//  pChart
//
//  Created by Kaique Torres on 4/23/24.
//

import Foundation
import FirebaseFirestoreSwift

struct NoteModel: Codable, Identifiable {
    
    @DocumentID var id: String?
    
    var patientID: String
    var title: String
    var noteContent: String
    var createdAt: String
    var updateAt: String
    var createdBy: String
}
