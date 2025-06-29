#  ToDo Task Manager App

A cross-platform mobile app built using **Flutter** that allows users to manage tasks efficiently with a beautiful and responsive UI, Google Sign-In, and Firestore integration for persistent cloud storage.

---

##  Features

-  **Google Sign-In Authentication**
-  **Add, Edit, Delete Tasks**
-  **Mark tasks as completed**
-  **Search Bar** to filter tasks
-  **Tab Filters**: All / Completed / Pending
-  **Pull to Refresh** and Swipe-to-Delete
-  Clean, colorful UI with Material Design
-  Firebase Firestore for secure, real-time storage
-  Data synced across devices for each user

---

##  Technologies Used

- Flutter (Dart)
- Firebase Authentication
- Firebase Cloud Firestore
- Provider (for state management)
- Material Design

---
# ToDo Task Manager 📝📱

A clean and modern task management mobile app built using **Flutter**, with **Firebase Authentication** (Google Sign-In) and **Cloud Firestore** for data persistence.  
This app was developed as part of a hackathon challenge hosted by [Katomaran](https://www.katomaran.com).

---

##  Features

- **Google Sign-In** using Firebase Auth  
- **Add / Edit / Delete Tasks**  
- **Swipe-to-Delete** with confirmation  
- **Mark tasks as Completed or Pending**  
- **Search Tasks** by title or description  
- **Pull-to-Refresh**  
- **Tabbed Filtering:** All / Completed / Pending  
- **Firestore Sync:** Tasks stored per user  
- **Beautiful UI:** Styled with `blue` themed Material design  
- Persistent login — skip login if already authenticated  
- **Firebase Crashlytics** ready (add key if enabled)

---

##  Project Structure

```bash
todo_task_app/
├── lib/
│   ├── models/
│   │   └── task.dart
│   ├── providers/
│   │   └── task_provider.dart
│   ├── screens/
│   │   ├── login_screen.dart
│   │   ├── home_screen.dart
│   │   └── add_edit_task_screen.dart
│   ├── widgets/
│   │   └── task_tile.dart
│   └── main.dart
├── assets/
│   └── icons, images, screenshots
├── firebase/
│   └── google-services.json
├── architecture.png         <-- ✅ Architecture Diagram
├── README.md                <-- ✅ This file
├── pubspec.yaml
└── .gitignore
```
---

## Setup Instructions
## Clone the Repository

```bash
Copy code
git clone https://github.com/your-username/ToDo-Task-Manager.git
```
## Install Dependencies

```bash
Copy code
flutter pub get
```
## Set up Firebase

Create a Firebase project at console.firebase.google.com

Enable Authentication > Google Sign-In

Enable Firestore Database

Download google-services.json and place it in android/app/

## Run the App

```bash
Copy code
flutter run
```
## Build APK (Optional)

```bash
Copy code
flutter build apk
```

---

## Demo video

https://drive.google.com/file/d/1upJ1S5dBXlL_4bwn_DKJbAEdlCHM2B7C/view?usp=drive_link

---

## Architecture diagram

![todo drawio](https://github.com/user-attachments/assets/9da78d05-8937-487b-b124-ec865f73f103)

---

## This project is a part of a hackathon run by https://www.katomaran.com

