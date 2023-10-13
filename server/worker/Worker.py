from io import BytesIO
from PIL import Image

from lwcc import LWCC
from torchvision import transforms
import torch


class Worker:
    model = LWCC.load_model()

    @staticmethod
    def get_people_count(image_bytes: BytesIO) -> float:
        trans = transforms.Compose([
            transforms.ToTensor(),
            transforms.Normalize([0.485, 0.456, 0.406], [0.229, 0.224, 0.225])
        ])

        image = Image.open(image_bytes).convert('RGB')
        image = torch.cat([trans(image).unsqueeze(0)])

        with torch.set_grad_enabled(False):
            outputs = Worker.model(image)

        counts = torch.sum(outputs, (1, 2, 3)).numpy()

        return counts[0]
