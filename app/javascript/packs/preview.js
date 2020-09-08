const inputImageFile = document.getElementById('input-image-file')
const previewContainer = document.getElementById('imagePreview');
const previewImage = previewContainer.querySelector('.imagePreview__image');
const previewDefaultText = previewContainer.querySelector('.imagePreview__defaultText');

inputImageFile.addEventListener('change', function () {
  const file = this.files[0]

  if (file) {
    const reader = new FileReader();

    previewDefaultText.style.display = 'none';
    previewImage.style.display = 'block';

    reader.addEventListener("load", function () {
      previewImage.setAttribute("src", this.result)
    })

    reader.readAsDataURL(file)
  }
  else {
    previewImage.style.display = null;
    previewDefaultText.style.display = null;
    previewImage.setAttribute("src", "");
  }
})