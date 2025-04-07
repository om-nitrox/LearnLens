# 📚 LearnLens – AI-powered Image-to-Leaning Modules App

LearnLens is an intelligent mobile application that transforms images of text (from books, notes, or handouts) into interactive *quizzes, **flashcards, and **summaries* using *OCR* and *Google's Gemini AI*. Designed to boost self-learning, it's ideal for students and learners who want to study efficiently on the go.
BY - 
- Om Pandey (23bds040)
- Prathamesh Patil (23bds043)
- Avishi Agarwal (23bds074)
- Vishavjeet Yadav (23bds069)
---

## ✨ Features

- 📷 Capture or upload text images
- 🔍 Extract text using Google ML Kit
- 🧠 Generate summaries of the text
- ❓ Auto-generate multiple-choice quizzes
- 🃏 Create educational flashcards
- 📱 Clean Flutter UI for seamless interaction

---

## 🛠 Tech Stack

| Component              | Technology Used                          |
|------------------------|------------------------------------------|
| Frontend Framework     | Flutter                                  |
| Language               | Dart                                     |
| OCR Engine             | Google ML Kit Text Recognition           |
| AI Integration         | Gemini API via google_generative_ai   |
| Image Picker           | image_picker package                   |
| State Management       | Stateful Widgets                         |

---

## ⚙ Prerequisites

Make sure you have the following installed:

- ✅ [Flutter SDK](https://docs.flutter.dev/get-started/install)
- ✅ Android Studio or Visual Studio Code with Flutter extension
- ✅ Dart SDK (comes with Flutter)
- ✅ An emulator or Android device
- ✅ A valid Gemini API Key from [Google AI Studio](https://makersuite.google.com/)

---

## ⚙ How to Install & Run

```bash
# Clone the repository
git clone https://github.com/om-nitrox/LearnLens.git
cd LearnLens

# Install dependencies
flutter pub get

# Add your Gemini API key
# Replace YOUR_API_KEY_HERE in ai_service.dart
final model = GenerativeModel(
  model: 'gemini-pro',
  apiKey: 'YOUR_API_KEY_HERE',
);

# Launch app on emulator or device
flutter run
```

# 🐞 Known Issues
- Inconsistent formatting from Gemini API (e.g., ```json)
- Dart strict typing requires careful type conversion
- Parsing fails if model output structure varies

# 🚀 Future Enhancements
- 🔊 Text-to-speech support
- 🧠 Spaced repetition flashcards
- 🌐 Multilingual recognition
- 💾 Persistent storage for user content
- 🧩 Advanced question types (drag, fill-in-the-blanks)
- 🖼 Image previews of generated content

# 🤝 Contributing
Pull requests are welcome. For any major changes, please open an issue first to discuss what you'd like to contribute.

# 📜 License
MIT License © 2025 Om Nitrox
