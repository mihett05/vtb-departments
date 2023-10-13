from io import BytesIO
from PIL import Image

from torchvision import transforms
import torch

from model.model import Model


class Worker:
    model = Model.load_model()
    transformer = transforms.Compose([
        transforms.ToTensor(),
        transforms.Normalize([0.485, 0.456, 0.406], [0.229, 0.224, 0.225])
    ])

    @staticmethod
    def get_people_count(image_bytes: BytesIO) -> float:
        image = Image.open(image_bytes).convert('RGB')
        image = torch.cat([Worker.transformer(image).unsqueeze(0)])

        with torch.set_grad_enabled(False):
            outputs = Worker.model(image)

        counts = torch.sum(outputs, (1, 2, 3)).numpy()

        return counts[0]


if __name__ == '__main__':
    img = Image.open('crowd_4.jpg')
    stream = BytesIO()
    img.save(stream, 'JPEG')
    stream.seek(0)

    print(Worker.get_people_count(stream))
