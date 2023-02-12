#!/bin/bash
#

# mamba install -c intel -y numpy
# mamba install -c bioconda -y spectrum_utils=0.3.5
# mamba install -y configargparse cython joblib matplotlib \
#     numba numexpr pandas pyteomics scipy \
#     tqdm -c defaults -c bioconda -c conda-forge

python3 -m pip install mmh3
mamba install -c pytorch -y faiss-cpu
python3 -m pip install ann_solo
