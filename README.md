## Getting Started
This project is a starting point for a Flutter application.
A few resources to get you started if this is your first Flutter project:
- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)
- [Knowledge about Flutter Packages](https://pub.dev)
- [Dataset Used for ML Implementation](https://www.kaggle.com/datasets/uciml/pima-indians-diabetes-database)
- [Dataset used for DL Implementation & Knowledge Article]
-     
For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
Certainly! Below is a sample GitHub README for your Mobile Diabetic App. Feel free to customize it further based on your project specifics:
---
# Mobile Diabetic App
## Overview

The **Mobile Diabetic App** is a comprehensive solution for managing diabetes, providing users with tools to monitor blood sugar levels, track medications, and receive personalized insights. The app is built using **Flutter** and **Dart**, making it cross-platform and efficient.
## Dataset:

## Features

1. **User Interface (UI)**:
    - The app boasts an intuitive and user-friendly interface designed with Flutter widgets. Users can easily navigate through different sections, view charts, and input data.
2. **Machine Learning Models**:
    - We've integrated several machine learning models to enhance the app's functionality:
        - **Random Forest**: Predicts blood sugar levels based on historical data.
        - **Decision Trees**: Assists in identifying patterns and correlations.
        - **Support Vector Machines (SVM)**: Classifies data points.
        - **XGBoost**: Boosted decision trees for accurate predictions.
3. **Deep Learning Models for Diabetic Retinopathy**:
    - Our app includes deep learning models trained to detect diabetic retinopathy from retinal images. Users can upload retinal images, and the app will provide a risk assessment.
4. **Firebase Integration**:
    - We leverage Firebase for seamless authentication and secure storage of user data. Firebase Authentication ensures user privacy, while Firebase Cloud Firestore stores relevant information.
## Installation
1. Clone the repository:
    ```bash
    git clone https://github.com/your-username/mobile-diabetic-app.git
    ```

2. Install dependencies:
2. Remember to install all the necessary python and dart dependencies:
    ```bash
    cd mobile-diabetic-app
    flutter pub get
    ```

3. Run the app:
    ```bash
    flutter run
    ```
4. Run Backend Prediction Server:
   '''bash
   app_rfc.py & 13.py contain the ML Backend Prediciton Server & DL Backend Prediction Server Respectively.
   '''
## Contributing

Contributions are welcome! If you'd like to improve the app or add new features, feel free to submit a pull request.
## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
---
