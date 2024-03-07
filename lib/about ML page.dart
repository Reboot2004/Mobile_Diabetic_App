import 'package:flutter/material.dart';
import 'package:mobilediabeticapp/userpredictions.dart';

import 'MLModel.dart';
import 'RDL.dart';
import 'config.dart';
import 'h.dart';
import 'login.dart';

class TestingMethodsPage extends StatefulWidget {
    final String username;

    const TestingMethodsPage({Key? key, required this.username}) : super(key: key);

    @override
    _TestingMethodsPageState createState() => _TestingMethodsPageState();
}
class _TestingMethodsPageState extends State<TestingMethodsPage> {
    final List<Map<String, dynamic>> parameters = [
        {
            'name': 'Diabetes Pedigree Function',
            'description': '''
Diabetes pedigree function (DPF) estimates diabetes likelihood depending on the subject’s age and his/her diabetic family history, which are considered as the primary risk factors of the diabetes disease. Family clinical history reveals important genomic information, which characterizes the joint interactions between behavioral, environmental, and genetic factors.

The Diabetes Pedigree Function (DPF) is a numerical score used to assess the genetic predisposition to diabetes in individuals. It is often used in medical research and clinical practice to evaluate the likelihood of developing diabetes based on family history. The DPF score is calculated based on the presence of diabetes in relatives, particularly parents and siblings.

The DPF score is typically calculated using a simple formula that assigns points based on the number and degree of affected relatives:
1. Each affected first-degree relative (parent, sibling) contributes 2 points to the DPF score.
2. Each affected second-degree relative (grandparent, aunt, uncle) contributes 1 point to the DPF score.

The total DPF score is obtained by summing the points from all affected relatives. A higher DPF score indicates a greater genetic predisposition to diabetes due to family history.
''',
        },
        {
            'name': 'Blood Pressure',
            'description': '''Blood Pressure (BP) is a vital health indicator that reflects the force exerted by your blood against the walls of your arteries. Let's dive into the details:

1. Measurement and Calculation:
   - BP is typically measured using a "Sphygmomanometer". It provides two key numbers:
     - Systolic Blood Pressure: The top number, representing the force when your heart beats.
     - Diastolic Blood Pressure: The bottom number, indicating the force between heartbeats.
   - The unit of measurement is millimeters of mercury (mmHg).
2. Normal Blood Pressure:
   - Systolic: 90 to 120 mmHg
   - Diastolic: 60 to 80 mmHg
3. High Blood Pressure (Hypertension):
   - Elevated: Systolic 120-129 mmHg, Diastolic < 80 mmHg.
   - Stage 1: Systolic 130-139 mmHg, Diastolic 80-89 mmHg.
   - Stage 2: Systolic ≥ 140 mmHg, Diastolic ≥ 90 mmHg.
   - Hypertensive Crisis: BP > 180/120 mmHg
4. Low Blood Pressure (Hypotension):
   - Systolic ≤ 90 mmHg
   - Diastolic ≤ 60 mmHg
            ''',
        },
        {
            'name': 'Glucose',
            'description': '''Glucose, often referred to as blood sugar, plays a crucial role in our health. Let's break it down:

1. Significance:
   - Glucose serves as the primary energy source for our cells. It fuels our muscles, brain, and other vital organs.
   - Maintaining optimal glucose levels is essential for overall well-being.
   
2. Measurement and Calculation:
   - There are two common ways to measure blood glucose levels:
     - Blood Sugar Test: This provides the current glucose level in the blood.
     - A1C Test: This measures the average blood glucose level over the past 2–3 months.
   - Normal fasting blood glucose levels for someone without diabetes range from 70 to 99 mg/dL (3.9 to 5.5 mmol/L).
   - Two hours after eating, a normal blood sugar level should be less than 140 mg/dL.
   
3. Range:
   - Normal:
     - Fasting: 70–99 mg/dL
     - 2 hours after a meal: Less than 140 mg/dL
   - Abnormal:
     - Hypoglycemia (low blood sugar): 70 mg/dL or less
     - Hyperglycemia (high blood sugar): More than 180 mg/dL

4. A1C test:
   -It is also known as the glycated hemoglobin or HbA1c test, provides valuable insights into your blood glucose control over the past 2–3 months. Here are the target levels:
    -For Most Adults with Diabetes:
        -Goal: An A1C level less than 7%.
    -For People Without Diabetes:
        -A normal A1C level is below 5.7%.
        -A1C falls between 5.7% and 6.4%, it signals prediabetes—a warning sign to take preventive measures.''',
        },
        {
            'name': 'BMI',
            'description': '''It provides insights into the relationship between your weight and height.
Calculation:
    BMI=weight(kg)/height(m)^2
Range:
    Underweight: BMI < 18.5
    Normal weight: BMI 18.5 to 24.9
    Overweight: BMI 25 to 29.9
    Obese: BMI ≥ 30
            ''',
        },
        {
            'name': 'Skin Thickness',
            'description': '''Measurement: Skinfold calipers are sometimes used to measure the thickness of the subcutaneous fat layer, which indirectly provides an estimation of skin thickness. 
Calipers are used to pinch and measure a fold of skin and underlying subcutaneous fat at specific anatomical sites, such as the triceps, biceps, and subscapular regions.
Unit: Millimeters (mm)
Range:
    Men 0.6-3.30 mm
    Women 1.30-3.10mm''',
        },
        {
            'name': 'Insulin',
            'description': '''Insulin is a crucial hormone produced by the pancreas. Let's delve into its significance, measurement, calculation, and normal range:
1. Units:
   - Insulin is typically measured in units (IU) or by volume in milliliters (mL).
   - 1 unit of insulin is approximately equal to 0.0347 milligrams (mg)
   
2. Significance of Insulin:
   - Role: Insulin helps regulate blood sugar levels by facilitating the uptake of glucose from the bloodstream into cells (especially muscles and fat tissue) and promoting its storage in the liver as glycogen.
   - Type 1 Diabetes: In type 1 diabetes (and advanced type 2 diabetes), the body cannot produce enough insulin, leading to elevated blood sugar levels and potential complications.
   - Insulin Resistance: In type 2 diabetes, insulin resistance occurs when cells do not respond effectively to insulin. The pancreas compensates by releasing extra insulin, resulting in elevated blood insulin levels.

3. Measurement and Calculation:
   - Fasting Insulin Test: This test measures insulin levels after at least 8 hours of fasting. It helps identify insulin resistance and abnormalities before blood sugar levels become problematic.
   - Other Tests: Besides fasting insulin, other tests include fasting blood glucose, hemoglobin A1C (HbA1c), fructosamine, and C-peptide.
   - Insulin Dose Calculation:
     - Basal Insulin (Background): About 40-50% of the total daily insulin dose replaces insulin overnight and between meals.
     - Bolus Insulin (Carbohydrate Coverage): The remaining 50-60% covers food intake and corrects high blood sugar.
     - Insulin-to-Carbohydrate Ratio: Typically, 1 unit of rapid-acting insulin covers 12-15 grams of carbohydrate.
     - High Blood Sugar Correction: Approximately 1 unit of insulin lowers blood glucose by 50 mg/dL.
     - Total Daily Insulin Requirement:
       - In pounds: Total Daily Insulin Requirement = Weight in Pounds ÷ 4.
       - In kilograms: Total Daily Insulin Requirement = 0.55 × Total Weight in Kilograms.

4. Normal Range:
   - The fasting insulin normal range varies slightly between labs but is generally considered to be around 2 to 20 mIU/mL.
   - Low insulin levels may be associated with various conditions; consult a healthcare professional for accurate diagnosis . 
  
5. C1 Peptide Bond Test:
          
    1. Procedure:
       - The C-peptide test measures the amount of C-peptide in either blood or urine.
       - It is often used to differentiate between Type 1 and Type 2 diabetes.
       - Additionally, it helps assess how well diabetes treatments are working and can aid in diagnosing other conditions.
    
    2. Measurement and Calculation:
       - A normal result for the C-peptide test ranges from 0.5 ng/mL to 2.0 ng/mL (or 0.17 to 0.83 nmol/L). Keep in mind that these values may slightly vary among different laboratories.
       - C-peptide is a byproduct released by the pancreas when it produces insulin. It reflects how much insulin the body is making.
       - The test distinguishes between endogenous (body-produced) insulin and exogenous (medication-derived) insulin.
       - C-peptide levels increase with weight and age in healthy individuals but decline over time in diabetics.
    
    3. Significance:
       - Type 1 Diabetes: In type 1 diabetes, the pancreas cannot make insulin. Individuals with this condition require insulin injections.
       - Type 2 Diabetes: People with type 2 diabetes either don't produce enough insulin or their bodies resist its effects. Some may need medications to manage glucose.
       - Hypoglycemia Investigation: The test helps investigate low blood sugar causes.
       - Other Conditions: It can aid in diagnosing pancreatic cancer, kidney failure, Cushing syndrome, or Addison disease.''',
        },
        {
            'name': 'Diabetic Retinopathy',
            'description' : '''
            Certainly! Let's delve into Diabetic Retinopathy (DR), covering its significance, measurement, calculation, and the range of features observed in the retina:

1. Significance:
   - Definition: Diabetic retinopathy is a condition characterized by damage to the retina due to diabetes.
   - Prevalence: It is a significant cause of visual loss worldwide and the primary reason for impaired vision in individuals aged 25 to 74 years.
   - Asymptomatic: DR is often asymptomatic until the late stages, making regular screening crucial for early detection.
   - Visual Impairment: Complications from DR can lead to serious vision problems, including macular edema, hemorrhage, retinal detachment, and neovascular glaucoma.

2. Measurement and Calculation:
   - Severity Classification:
     - DR is divided into two major forms:
       - Nonproliferative DR: Absence of abnormal new blood vessels from the retina.
       - Proliferative DR: Presence of abnormal new blood vessels.
     - DR can be further classified by severity, which helps guide treatment strategies.
   - Diabetic Macular Edema (ME):
     - ME may develop at any point along the spectrum from mild nonproliferative disease to proliferative DR.
     - It involves retinal thickening and edema affecting the macula (central part of the retina).
     - Treatment aims to reduce ME and preserve vision.

3. Range of Features in the Retina:
   - Vitreous Hemorrhage:
     - New blood vessels may bleed into the clear, jelly-like substance (vitreous) in the center of the eye.
     - Small bleeds result in dark spots (floaters).
   - Traction Retinal Detachment:
     - Abnormal blood vessels can cause the retina to detach.
     - Symptoms include blurred vision, floaters, and flashing lights (photopsias).
''',
        }
    ];
bool _isDark = true;
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text('Testing Methods'),
            ),drawer: Drawer(
            width: 200,
            backgroundColor: Theme.of(context).brightness != Brightness.dark ? Colors.white : Colors.black,
            child: Padding(
                padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: Column(
                    children: [
                        Center(child:
                        //Text('Menu', style: TextStyle(fontSize: 37.5, color: !_isDark ? Colors.black : Colors.white)),
                        Container(
                            color: Colors.transparent ,//!_isDark ? Colors.black : Colors.white, // Container color based on _isDark
                            width: 200,
                            height: 50,
                            alignment: Alignment.center,
                            child: Text(
                                'Menu',
                                style: TextStyle(
                                    fontSize: 37.5,
                                    color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, // Text color based on _isDark
                                ),
                            ),
                        ),
                        ),
                        Container(
                            width: 200,
                            color: Colors.transparent,//_isDark ? Colors.black87 : Colors.white,
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: TextButton(
                                onPressed: () {
                                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => WelcomeScreen(username: widget.username)),(Route<dynamic> route) => false,);
                                },
                                child: Text(
                                    "Home",
                                    style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, fontSize: 18),
                                ),
                            ),
                        ),
                        Container(
                            width: 200,
                            color: Colors.transparent,
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: TextButton(
                                onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => MLModel(username: widget.username)));
                                },
                                child: Text(
                                    "ML Model",
                                    style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, fontSize: 18),
                                ),
                            ),
                        ),
                        Container(
                            width: 200,
                            color: Colors.transparent,
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: TextButton(
                                onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => RetinopathyScreen(username: widget.username)));
                                },
                                child: Text(
                                    "Retinopathy DL",
                                    style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, fontSize: 18),
                                ),
                            ),
                        ),
                        Container(
                            width: 200,
                            color: Colors.transparent,
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: TextButton(
                                onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => UserPredictionsPage(username: widget.username)));
                                },
                                child: Text(
                                    "Previous Predictions",
                                    style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, fontSize: 18),
                                ),
                            ),
                        ),
                        Container(
                            width: 200,
                            color: Colors.transparent,
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: TextButton(
                                onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => TestingMethodsPage(username: widget.username)));
                                },
                                child: Text(
                                    "About",
                                    style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, fontSize: 18),
                                ),
                            ),
                        ),
                        Container(
                            width: 200,
                            color: Colors.red,
                            margin: EdgeInsets.fromLTRB(0, 100, 0, 10),
                            child: TextButton(
                                onPressed: () {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(builder: (context) => Login()), // Ensure Login() is correctly instantiated
                                            (Route<dynamic> route) => false,
                                    );
                                },
                                child: Row(
                                    children: [
                                        Icon(Icons.logout, color: Colors.white),
                                        SizedBox(width: 10), // It's better to use SizedBox for spacing
                                        Text(
                                            "Logout",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                            ),
                                        ),
                                    ],
                                ),
                            ),
                        ),
                        Container(
                            width: 100,
                            margin: EdgeInsets.fromLTRB(100, 10, 0, 10),
                            child: TextButton(
                                onPressed: () {
                                    setState(() {
                                        _isDark = !_isDark; // Toggle the theme state
                                        currentTheme.switchTheme(); // Assuming you have a theme switcher
                                    });
                                },
                                style: TextButton.styleFrom(
                                    primary: Colors.transparent, // Removes any splash color
                                    onSurface: Colors.transparent, // Removes any surface color in disabled state
                                ),
                                child: Icon(
                                    Theme.of(context).brightness != Brightness.dark ? Icons.sunny : Icons.bedtime, // Toggle the icon based on the theme state
                                    color: Theme.of(context).brightness != Brightness.dark ?  Colors.orange : Colors.grey, // Icon color based on _isDark
                                ),
                            ),
                        ),
                    ],
                ),
            ),
        ),
            body: ListView.builder(
                itemCount: parameters.length,
                itemBuilder: (context, index) {
                    var parameter = parameters[index];
                    return Card(
                        margin: EdgeInsets.all(8),
                        child: ExpansionTile(
                            title: Text(parameter['name'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Text(parameter['description'], style: TextStyle(fontSize: 16)),
                                ),
                            ],
                        ),
                    );
                },
            ),
        );
    }
}
