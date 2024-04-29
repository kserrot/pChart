pChartApp Application

Overview:
pChartApp is a robust application designed for managing patient charts seamlessly using SwiftUI and Firebase services. It integrates Firebase for backend operations including authentication, storing, and managing patient notes.


Features:
Firebase Authentication: Manages user sign-in, sign-up, and sign-out functionalities.
Patient Notes Management: Enables users to create, update, and view patient charts.
Real-Time Data Sync: Uses Firestore to fetch and update data asynchronously, ensuring that the patient charts are always current.


Key Components:

AppDelegate:
Initializes Firebase when the app launches.


pChartApp Structure:
Sets up the primary navigation and integrates ContentView for displaying the main interface.


NoteModel:
Defines the structure for patient notes including attributes like patientID, title, noteContent, etc.


NoteViewModel:
Handles fetching and updating patient notes from Firestore.
Implements asynchronous data operations to ensure UI responsiveness.


AuthViewModel:
Manages authentication states and performs user authentication operations such as sign-in, sign-up, and sign-out.


NoteDetail:
Provides a detailed view for editing a patient's note.
Includes form inputs and a save button to submit changes.


AuthView:
Allows users to either log in or register.
Switches view based on authentication status.


ContentView:
Serves as the root view, deciding which view to present based on the user's authentication status.
Displays patient charts for authenticated users and authentication options for non-authenticated users.


Setup:
Firebase Configuration:
Ensure that your Firebase project is set up and configured correctly.
Update your Info.plist with your Firebase project configuration details.


Firestore Database:
Set up Firestore collections as per the NoteModel structure.


SwiftUI Views:
Ensure all views are correctly linked to their respective ViewModels for functionality.


Dependencies:
FirebaseCore, FirebaseFirestore, FirebaseFirestoreSwift, and FirebaseAuth need to be included in your project.


Usage:
Launch the app and sign in or sign up.
Navigate through the patient charts or create new ones.
Use the detailed view to edit and update patient notes.
