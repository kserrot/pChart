//
//  ContentView.swift
//  pChart
//
//  Created by Kaique Torres on 4/23/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var noteApp = NoteViewModel()
    @State var note = NoteModel(patientID: "", title: "", noteContent: "", createdAt: "", updateAt: "", createdBy: "")
    @StateObject var authViewModel = AuthViewModel()
    @StateObject var noteVM = NoteViewModel()

    var body: some View {
        if authViewModel.isAuthenticated {
            NavigationView {
                ZStack{
                    List {
                        ForEach($noteApp.patientNotes.indices, id: \.self) { index in
                            NavigationLink(destination: NoteDetail(note: $noteApp.patientNotes[index])) {
                                Text(noteApp.patientNotes[index].patientID)
                            }
                        }
                        
                        //.listRowBackground(Color.accentColor.opacity(0.5))
                        
                        Section{
                            NavigationLink{
                                NoteDetail(note: $note)
                            } label: {
                                Text("New Chart")
                                    .foregroundColor(Color.gray)
                                    .font(.system(size: 15))
                            }
                            //.listRowBackground(Color.accentColor.opacity(0.5))
                        }
                        .listStyle(GroupedListStyle())
                        //.listRowBackground(Color.accentColor.opacity(0.5))
                    }
                    .navigationTitle("Patient Charts")
                    
                    
                    .navigationBarItems(trailing: Button("Sign Out") {
                        authViewModel.signOut()
                        print("User out")
                    }
                        .buttonStyle(ProminentButtonStyle()))
                    .onAppear {
                        Task {
                            await noteApp.fetchData()
                        }
                        
                    }
                }
                .padding()
                .background(Color.accentColor.opacity(0.7))
            }
        } else {
            AuthView().environmentObject(authViewModel)
        }
    }
}


struct ProminentButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.accentColor) // Use a contrasting color for the button background
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .scaleEffect(configuration.isPressed ? 0.70 : 0.80)
            //.shadow(radius: configuration.isPressed ? 0 : 3)
            .animation(.spring(), value: configuration.isPressed)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthViewModel())
            .environmentObject(NoteViewModel())
            //.background(Color.blue)
    }
}
