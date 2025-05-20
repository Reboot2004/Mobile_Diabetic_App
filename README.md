# Mobile Diabetic App

![Diabetes Prediction App](https://img.shields.io/badge/Flutter-Diabetes%20Prediction-blue)
![ML & DL](https://img.shields.io/badge/ML%20%26%20DL-Enabled-green)

A mobile application built with Flutter that utilizes Machine Learning and Deep Learning techniques to predict diabetes risk and detect diabetic retinopathy from retinal images.

## Overview

The Mobile Diabetic App is designed to help users assess their risk of diabetes through advanced predictive models and monitor for diabetic retinopathy complications. By leveraging both ML and DL algorithms, the app provides personalized risk assessments based on user-provided health data and retinal scans.

## Technologies Used

- **Frontend**: Flutter/Dart (94.1%)
- **Backend**: Python (5.5%) for ML/DL models
- **Other**: Configuration and assets (0.4%)

## Features

- **Diabetes Risk Prediction**: Input health parameters to receive a diabetes risk assessment
- **Diabetic Retinopathy Detection**: Analyze retinal images to detect signs of diabetic retinopathy
- **User-Friendly Interface**: Intuitive design for easy navigation and data input
- **Personalized Health Insights**: Receive tailored feedback based on your health metrics
- **Secure Data Handling**: Your health information remains private and secure

## Machine Learning Models

The app incorporates specialized machine learning and deep learning models to provide accurate predictions and detection:

1. **Diabetes Prediction Model**:
   - Analyzes various health parameters including:
     - Blood glucose levels
     - BMI (Body Mass Index)
     - Blood pressure
     - Age
     - Family history of diabetes
     - Other relevant health metrics

2. **Retinopathy Detection Model**:
   - Uses computer vision and deep learning to analyze retinal images
   - Detects and classifies stages of diabetic retinopathy
   - Provides early warning for vision-threatening complications

## Project Structure

```
Mobile_Diabetic_App/
├── android/               # Android-specific files
├── ios/                   # iOS-specific files
├── lib/                   # Main Dart source code
│   ├── main.dart          # Application entry point
│   ├── models/            # Data models
│   ├── screens/           # UI screens
│   │   ├── home/          # Home screen components
│   │   ├── prediction/    # Diabetes prediction screens
│   │   ├── retinopathy/   # Retinopathy detection screens
│   │   └── profile/       # User profile screens
│   ├── services/          # Backend services
│   │   ├── api/           # API communication
│   │   └── ml/            # ML model integration
│   ├── utils/             # Utility functions
│   └── widgets/           # Reusable UI components
├── ml/                    # Python ML/DL model files
│   ├── diabetes_model/    # Diabetes prediction models
│   └── retinopathy_model/ # Retinopathy detection models
├── assets/                # Images, fonts, and other static resources
│   ├── images/            # Image assets
│   └── model_files/       # Trained model files
├── test/                  # Test files
├── pubspec.yaml           # Flutter package dependencies
└── README.md              # Project documentation
```

## Installation

1. Ensure you have Flutter installed on your system
2. Clone the repository:
   ```
   git clone https://github.com/Reboot2004/Mobile_Diabetic_App.git
   ```
3. Navigate to the project directory:
   ```
   cd Mobile_Diabetic_App
   ```
4. Install dependencies:
   ```
   flutter pub get
   ```
5. Run the app:
   ```
   flutter run
   ```

## Development Status

This application is currently under active development. Future updates will include:
- Enhanced prediction accuracy
- Additional health metrics tracking
- Integration with healthcare provider systems
- More advanced retinopathy staging and monitoring

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is proprietary and is not licensed for redistribution without explicit permission.

---

Developed by [Reboot2004](https://github.com/Reboot2004)
Last updated: 2025-05-20
