# detector.py

import json
import os
from pathlib import Path
from collections import Counter
import sys
from PIL import Image, ImageDraw
import cv2
import face_recognition
import pickle


DEFAULT_ENCODINGS_PATH = os.path.join(os.getcwd(), 'face_recognition_system/output/encodings.pkl')

Path("training").mkdir(exist_ok=True)
Path("output").mkdir(exist_ok=True)
Path("validation").mkdir(exist_ok=True)


BOUNDING_BOX_COLOR = "blue"
TEXT_COLOR = "white"


def _display_face(draw, bounding_box, name):
    top, right, bottom, left = bounding_box
    draw.rectangle(((left, top), (right, bottom)), outline=BOUNDING_BOX_COLOR)
    text_left, text_top, text_right, text_bottom = draw.textbbox(
        (left, bottom), name
    )
    draw.rectangle(
        ((text_left, text_top), (text_right, text_bottom)),
        fill="blue",
        outline="blue",
    )
    draw.text(
        (text_left, text_top),
        name,
        size = 32,
        fill="white",
    )
    
def get_all_registered_names(encodings_location) -> dict:
  try:
    with open(encodings_location, "rb") as f:
      loaded_encodings = pickle.load(f)
    
    # Create a dictionary with all names initialized as absent
    names_dict = {name: 'absent' for name in loaded_encodings["names"]}
    
    return names_dict
  except Exception as e:
    print(f"Error getting names: {e}")
    return f"Error getting names: {e}"

def encode_known_faces(
    encodings_location: Path,
    model: str = "hog"
) -> None:
    try:
        names = []
        encodings = []

        for filepath in Path(f"training/{encodings_location}").glob("*/*"):
            name = filepath.parent.name
            image = face_recognition.load_image_file(filepath)

            face_locations = face_recognition.face_locations(image, model=model)
            face_encodings = face_recognition.face_encodings(image, face_locations)

            for encoding in face_encodings:
                names.append(name)
                encodings.append(encoding)

        name_encodings = {"names": names, "encodings": encodings}
        with open(f'{encodings_location}/encodings.pkl', mode="wb") as f:
            pickle.dump(name_encodings, f)
            
        return {'message': 'success'}
    
    except Exception as error:
        return f'{error}'

def _recognize_face(unknown_encoding, loaded_encodings):
    boolean_matches = face_recognition.compare_faces(
        loaded_encodings["encodings"], unknown_encoding
    )
    votes = Counter(
        name
        for match, name in zip(boolean_matches, loaded_encodings["names"])
        if match
    )
    if votes:
        return votes.most_common(1)[0][0]

def recognize_faces(
    # attendance: list,
    image_location: str,
    encodings_location: Path,
    model: str = "hog",
) -> None:
    
    currentAttendance = get_all_registered_names(encodings_location=DEFAULT_ENCODINGS_PATH)
    
    try:

        with open(encodings_location, "rb") as f:
            loaded_encodings = pickle.load(f)

        input_image = face_recognition.load_image_file(image_location)

        input_face_locations = face_recognition.face_locations(
            input_image, model=model
        )
        input_face_encodings = face_recognition.face_encodings(
            input_image, input_face_locations
        )
        
        pillow_image = Image.fromarray(input_image)
        draw = ImageDraw.Draw(pillow_image)

        for bounding_box, unknown_encoding in zip(
            input_face_locations, input_face_encodings
        ):
            name = _recognize_face(unknown_encoding, loaded_encodings)
            if not name:
                name = "Unknown"
            # print(name, bounding_box)
            currentAttendance[name] = 'present'
            # _display_face(draw, bounding_box, name)
        
        return currentAttendance
    
    except Exception as error:
        return f'{error}'
    
    # print(f"{counter} faces")
    # print(currentAttendance)
    # del draw
    # pillow_image.show()

if __name__ == "__main__":
    try:
        if (sys.argv[1] == "recognize"):
            image_data_base64 = sys.argv[2]
            encodings_location = sys.argv[3]
            result = recognize_faces(image_location=os.path.join(os.getcwd(), f'face_recognition_system/test/{image_data_base64}'), encodings_location=os.path.join(os.getcwd(), rf'face_recognition_system\test\{encodings_location}'))
            print(json.dumps(result))
            
        elif (sys.argv[1] == "setup"):
            encodings_path = sys.argv[2]
            result = encode_known_faces(encodings_location=os.path.join(os.getcwd(), f'face_recognition_system/training/{encodings_path}'))
            print(json.dumps(result))
    
    except Exception as e:
        print(json.dumps({'error': e}))
        
    finally:
        sys.stdout.flush()
        
    # python main.py setup path_to_training_data path_to_encodings