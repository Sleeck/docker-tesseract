# docker-tesseract

jpg to pdf conversion with Tesseract


```
curl -X POST "http://dockerhost:8000/ocr/pdf" -H "Content-Type: multipart/form-data" -F "image=@source.jpg;type=image/jpeg" -F "lang=fra+eng" --output output.pdf
```

Web interface at http://0.0.0.0:8000/apidocs/


```
  tesseract:
    image: sleeck/tesseract:latest
    restart: always
    container_name: tesseract
    ports:
      - 8000:8000
```

```
docker run -it -p 8000:8000 tesseract
```