# Use an official PyTorch image as a base
FROM pytorch/pytorch:2.0.0-cuda11.7-cudnn8-runtime

# Set a working directory
WORKDIR /workspace

COPY clip .
COPY tests .
COPY hubconf.py .
COPY setup.py .

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Install Python packages
RUN pip install --upgrade pip && \
    pip install \
    clip-by-openai \
    torchvision \
    Pillow \
    numpy \
    tqdm

COPY requirements.txt .
RUN pip install -r requirements.txt

# Clone the CLIP repository
RUN git clone https://github.com/openai/CLIP.git /workspace/CLIP

# Set the entry point to bash
CMD ["bash"]