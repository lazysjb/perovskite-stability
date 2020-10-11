##Predicting the Thermodynamic Stability

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
- How to predict stability of compounds not in the training set?

[TODO]
- Author extracts features using MAGPIE 
    - lets try python magpie to understand how this
      is done [MAGPIE Python](https://bitbucket.org/wolverton/magpie-python/src/master/)
