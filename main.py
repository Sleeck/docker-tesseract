from flask import Flask, request
from flasgger import Swagger
import pytesseract
from tempfile import NamedTemporaryFile

app = Flask(__name__)
app.config['SWAGGER'] = {
    'title': 'Tesseract - image to pdf',
}

Swagger(app)


@app.route('/ocr/pdf', methods=['POST'])
def get_ocr_pdf():
    """
    OCR image to pdf
    ---
    tags:
      - stream
    parameters:
      - in: formData
        name: image
        type: file
        required: true
        description: Image file
      - in: formData
        name: lang
        type: string
        required: true
        description: Language
    responses:
      500:
        description: Error message
      200:
        description: Pdf file
    """

    if 'image' not in request.files:
        return "No file uploaded"

    image_file = request.files['image']

    if image_file.filename == '':
        return "No file name"

    if request.form['lang'] == '':
        return "No language defined"

    file = NamedTemporaryFile()
    image_file.save(file.name)

    pdf = pytesseract.image_to_pdf_or_hocr(file.name, lang=request.form['lang'], config='', nice=0, extension='pdf')

    return pdf


if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0', port=8000)
