## Predicting the Thermodynamic Stability

- Thermodynamic phase stability is a key param that governs whether the 
material is expected to be synthesizable, and whether it may degrade under 
certain conditions.
- Phase stability (calculated as energy above 
the convex hull) can be calculated using DFT but significant computational cost
- Author’s metrics
    - 0.93 accuracy / 0.88 f1 - classification: 
    stable vs. unstable
    - 28.5 meV / atom RMSE - regression

[Question]
- Should we start off with the original 960 features, or the top 70 features?
    - Original features in [Supplement Section](https://www.sciencedirect.com/science/article/pii/S2352340918305092?via%3Dihub#ec1005)
    - Generation of original features in [Author Repository](https://github.com/uw-cmg/perovskite-oxide-stability-prediction) 

- How to predict stability of compounds not in the training set?

[TODO]
- Author extracts features using MAGPIE 
    - lets try python magpie to understand how this
      is done [MAGPIE Python](https://bitbucket.org/wolverton/magpie-python/src/master/)
