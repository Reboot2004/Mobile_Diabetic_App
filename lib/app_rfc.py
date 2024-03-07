import json
from flask import Flask, jsonify, request
import numpy as np
import pandas as pd
from sklearn.preprocessing import StandardScaler
from sklearn.tree import DecisionTreeClassifier
from sklearn.ensemble import RandomForestClassifier
from xgboost import XGBClassifier
from sklearn.svm import SVC
import pickle
import warnings
warnings.filterwarnings('ignore')
from flask_cors import CORS
from sklearn.model_selection import train_test_split
app = Flask(__name__)
CORS(app)

warnings.filterwarnings('ignore')

# Load the diabetes dataset
diabetes_df = pd.read_csv("diabetes.csv")

# Data preprocessing
diabetes_df_copy = diabetes_df.copy(deep=True)
diabetes_df_copy[['Glucose', 'BloodPressure', 'SkinThickness', 'Insulin', 'BMI']] = diabetes_df_copy[
    ['Glucose', 'BloodPressure', 'SkinThickness', 'Insulin', 'BMI']].replace(0, np.NaN)

# Impute missing values
diabetes_df_copy['Glucose'].fillna(diabetes_df_copy['Glucose'].mean(), inplace=True)
diabetes_df_copy['BloodPressure'].fillna(diabetes_df_copy['BloodPressure'].mean(), inplace=True)
diabetes_df_copy['SkinThickness'].fillna(diabetes_df_copy['SkinThickness'].median(), inplace=True)
diabetes_df_copy['Insulin'].fillna(diabetes_df_copy['Insulin'].median(), inplace=True)
diabetes_df_copy['BMI'].fillna(diabetes_df_copy['BMI'].median(), inplace=True)

# Standardize the features
sc_X = StandardScaler()
X = pd.DataFrame(sc_X.fit_transform(diabetes_df_copy.drop(["Outcome"], axis=1)),
                 columns=['Pregnancies', 'Glucose', 'BloodPressure', 'SkinThickness', 'Insulin', 'BMI',
                          'DiabetesPedigreeFunction', 'Age'])

# Split the data into features (X) and target variable (y)
y = diabetes_df['Outcome']
X_train, X_test, y_train, y_test = train_test_split(X,y, test_size=0.33,random_state=7)

# Train the RandomForestClassifier
model = XGBClassifier()
model.fit(X, y)

# Save the model to a file
filename = 'xgb_model.pkl'
pickle.dump(model, open(filename, 'wb'))

# Function to make predictions
def predict(data):
    try:
        # if 'Random Forest' in data['Model']:
        #     loaded_model = RandomForestClassifier(n_estimators=200)
        #     loaded_model.fit(X_train, y_train)
        #     input_df = pd.DataFrame([data], columns=['Pregnancies', 'Glucose', 'BloodPressure', 'SkinThickness', 'Insulin', 'BMI', 'DiabetesPedigreeFunction', 'Age'])
        #     input_data = sc_X.transform(input_df)
        #     predictions = loaded_model.predict(input_data)
        #     print(predictions)
        #     return predictions.tolist()
        # if 'Decision Tree' in data['Model']:
        #     loaded_model = DecisionTreeClassifier()
        #     loaded_model.fit(X_train, y_train)
        #     input_df = pd.DataFrame([data], columns=['Pregnancies', 'Glucose', 'BloodPressure', 'SkinThickness', 'Insulin', 'BMI', 'DiabetesPedigreeFunction', 'Age'])
        #     input_data = sc_X.transform(input_df)
        #     predictions = loaded_model.predict(input_data)
        #     print(predictions)
        #     return predictions.tolist()
        # if 'XGBoost' in data['Model']:
        #     loaded_model = XGBClassifier(gamma=0)
        #     loaded_model.fit(X_train, y_train)
        #     input_df = pd.DataFrame([data], columns=['Pregnancies', 'Glucose', 'BloodPressure', 'SkinThickness', 'Insulin', 'BMI', 'DiabetesPedigreeFunction', 'Age'])
        #     input_data = sc_X.transform(input_df)
        #     predictions = loaded_model.predict(input_data)
        #     print(predictions)
        #     return predictions.tolist()
        # if 'SVM' in data['Model']:
        #     loaded_model = SVC()
        #     loaded_model.fit(X_train, y_train)
        #     input_df = pd.DataFrame([data], columns=['Pregnancies', 'Glucose', 'BloodPressure', 'SkinThickness', 'Insulin', 'BMI', 'DiabetesPedigreeFunction', 'Age'])
        #     input_data = sc_X.transform(input_df)
        #     predictions = loaded_model.predict(input_data)
        #     print(predictions)
        #     return predictions.tolist()
        input_df = pd.DataFrame([data], columns=['Pregnancies', 'Glucose', 'BloodPressure', 'SkinThickness', 'Insulin', 'BMI', 'DiabetesPedigreeFunction', 'Age'])
        input_data = sc_X.transform(input_df)

        predictions_list = []
        print(data['Model'])
        for model_name in data['Model']:
            if model_name == 'Random Forest':
                loaded_model = RandomForestClassifier(n_estimators=200)
            elif model_name == 'Decision Tree':
                loaded_model = DecisionTreeClassifier()
            elif model_name == 'XGBoost':
                loaded_model = XGBClassifier(gamma=0)
            elif model_name == 'SVM':
                loaded_model = SVC()
            else:
                # Handle unknown models
                print(f"Unknown model: {model_name}")
                continue

            loaded_model.fit(X_train, y_train)
            predictions = loaded_model.predict(input_data)
            predictions_list.append(predictions)
            pred = []
            c=0
        if (data['Model'] == 1):
            return predictions.list()
        else:
            for i in predictions_list:
                pred.append(str(i[0]));
                print(pred)
        # if predictions_list:
        #     print(predictions_list)
        #     pred =  [predictions.tolist() for predictions in predictions_list]
        return pred

        # input_df = pd.DataFrame([data], columns=['Pregnancies', 'Glucose', 'BloodPressure', 'SkinThickness', 'Insulin', 'BMI', 'DiabetesPedigreeFunction', 'Age'])
        # input_data = sc_X.transform(input_df)
        #
        # # Make predictions using the loaded model
        # predictions = loaded_model.predict(input_data)
        # print(predictions)
        # return predictions.tolist()
    except Exception as e:
        return {str(e)}

@app.route('/a', methods=['GET','POST'])
def make_prediction():
    try:
        data = request.get_json(force=True)
        #data1 = json.loads(data)
        print(data)
        prediction = predict(data)
        print(prediction)
        return jsonify({'prediction': prediction})
    except Exception as e:
        return jsonify("Flask Local Server: Running on http://172.26.24.215:5000                                          "
        "                        AWS Lightsail URL : https://flask-service.ipmpa2dupjgl8.us-east-1.cs.amazonlightsail.com/a")

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=3000, debug=True)