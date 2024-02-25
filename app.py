from flask import Flask, request, jsonify
import cv2
import os
from ultralytics import YOLO  # Assuming this is the correct import for your model
import glob

app = Flask(__name__)

# Load your model
model = YOLO('S:/Repo/VogueVoyage/clothing/assets/vv5.pt')

# Your class mapping
class_mapping = {0: 'Shirts', 1: 'Blazers', 2: 'Hoodies', 3: 'Skirts', 4: 'Jeans', 
                 5: 'Pants', 6: 'Tshirts', 7: 'Tops', 8: 'Sweatshirts', 
                 9: 'Shorts', 10: 'Sarees', 11: 'Dresses', 12: 'Shrugs', 
                 13: 'Jackets', 14: 'Sweaters', 15: 'Leggings'}

@app.route('/predict', methods=['POST'])
def predict():
    if 'file' not in request.files:
        return jsonify('No file part'), 400
    file = request.files['file']
    if file.filename == '':
        return jsonify('No selected file'), 400
    
    # Read and save the image file temporarily
    file_path = f"temp_{file.filename}"
    file.save(file_path)
    image = cv2.imread(file_path)

    # Perform prediction (assuming it saves predictions to a text file)
    model.predict(source=image, save=True, save_txt=True)

    # Assuming your predictions are saved in a structured directory like 'runs/detect'
    # Find the most recent prediction directory
    list_of_dirs = glob.glob('runs/detect/predict*')  # Adjust based on your directory structure
    latest_dir = max(list_of_dirs, key=os.path.getmtime)
    
    # Assuming the prediction file has a standard name or format, find it within the latest prediction directory
    prediction_files = glob.glob(f"{latest_dir}/labels/*.txt")
    if not prediction_files:
        return jsonify("No prediction file found"), 500
    latest_file = max(prediction_files, key=os.path.getmtime)

    # Read the prediction from the latest prediction file
    try:
        with open(latest_file, 'r') as file:
            first_line = file.readline().strip()
            class_id = int(first_line.split()[0])  # Assuming class ID is the first element
            class_name = class_mapping.get(class_id, "Unknown class")  # Map class ID to name
    except Exception as e:
        return jsonify(f"Error reading prediction file: {e}"), 500

    print(f"Returning label: {class_name}, Type: {type(class_name)}")
    return jsonify(class_name)  # Return just the class name string

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
