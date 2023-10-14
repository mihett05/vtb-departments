from lwcc.models.CSRNet import CSRNet
import torch


class Model:
    @staticmethod
    def load_model():
        model = CSRNet()
        model.load_state_dict(torch.load('worker/model/CSRNet_SHA.pth', map_location='cpu')["model"])
        return model
