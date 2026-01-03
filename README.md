# PDF Editor & Annotator

A robust Flutter application for viewing, annotating, and managing PDF documents. This app allows users to drag-and-drop text, dates, signatures, and checkboxes onto PDF pages, export these configurations via Firebase, and download the flattened final PDF.

## 🚀 Features

- **User Authentication:** Complete Login and Sign-up flow using Firebase Auth.
- **PDF Interaction:**
    - Pick and view PDF files locally.
    - Add **Text Boxes**, **Date Fields**, **Digital Signatures**, and **Checkboxes**.
    - Drag-and-drop elements to precise positions on any page.
- **Configuration Management:**
    - **Export:** Save your layout as a JSON configuration to Firestore and generate a shareable link (`pe-app://config/ID`).
    - **Import:** Restore annotations and positions using a shared link.
- **PDF Generation:** Merges (flattens) all annotations into the original PDF and saves it to the device's Download folder.
- **Responsive Design:** Built with `flutter_screenutil` to ensure UI consistency across different screen sizes.

---

## 🏗 Architecture & State Management

This project follows the **MVC (Model-View-Controller)** pattern combined with **GetX** for high-performance state management and dependency injection.

- **Model:** Defines the structure of draggable elements and data schemas.
- **View:** Clean UI components and screens, separated from business logic.
- **Controller:** Manages state, PDF logic, and coordinate calculations.
- **Service:** Persistent classes for Firebase Auth and Document database operations.
- **Bindings:** Uses `ControllerBinder` for lazy-loading controllers to optimize memory.

---

## 🛠 Setup Instructions

### 1. Prerequisites
- Flutter SDK installed (Stable channel recommended).
- Android Studio / VS Code with Flutter extensions.
- A Firebase Project.

### 2. Installation
```bash
# Clone the repository
git clone [https://github.com/yourusername/pdf_editor.git](https://github.com/yourusername/pdf_editor.git)

# Navigate to the project directory
cd pdf_editor

# Install dependencies
flutter pub get