# ML4MS notes

To look up:
- accessible mathematical introduction to machine learning (kernals etc): https://mml-book.github.io/
- https://www.inference.org.uk/itprnn/book.pdf
- https://www.nature.com/articles/nphys4053
- https://onlinelibrary.wiley.com/doi/full/10.1002/qua.24954
   
## Day One

### luca ghiringhelli, FHI, (SISSO)

- talk themes: compressed sensing / supervised learning / maps of material properties
- idea is to create maps of materials so that materials can be sorted into eg: ZB or rocksalt when given composition
- big picture: the preparaiton, synthesis, characterisation of materials is costly and complex, there are 240000 inorganic materials listed on Springer but most properties are not known
- the training --> descriptor --> learning --> prediction loop
- ML built on top of ab-initio calculations
- what does "big" mean? 4 V's: volume, velocity (cf. cern), variety, veracity

- usually we use ML when the laws are unknown. But in MS we know the laws! But the model is complex. So the ideas is to find descriptors which embed enough physical information so that the model itself is easy enough to solve.
- LG has an interest in course grained models: not where we worry about the exact positions of the atoms, but the topology (connectivity - what is connected to what)

- discussed points we have covered in group meetings: importance of training error & validation error to avoid under/over fitting, need for a diverse data set
- the main challenges are the descriptor, and getting a diverse data set.
- principal component analysis to find hte direction with the greatest variance (like finding long edge of cigar)

- LG gave a mathematical overview of ridge regression, kernal ridge regression, regularization - I need to re-visit slides to understand.
- key point: KRR uses a linear expansion of a non-linear kernal (equiv basis set?) so that we can get a non linear fit using linear algebra.

- to look up: 
   - nomad kaggle predicting TCO. The winner was a course grained model using a soap like descriptor + NN. The descriptor was a "dressed chemical species" - it showed that local topology can be more important that exact angles etc.
   - predicting xtal structure from composition: 82 data points for training set are possible if the correct descriptor and method is used.
   - 2014 PRB (Misner) - hole trapping depth
   - vidvudis ozilins  - use of compressed sensing and in 2013 cluster expansion "compressive sampling as a paradigm for building physics models"

### nong artrith columbia

- talk themes: MLPs for simulation of complex materials
- reference calc --> interpolate --> continuous PES --> MD, MC ets
- using neural nets for regression

- NNs are good for continuous functions
- The activation function
- A nice basic NN example - fitting a parabola


- ANN negatives:
  - can only be used for one number of atoms once trained
  - ANNs are not automatically invariant to rotation or exchange of identical atoms

- showed that to account for electrostatic interactions, can use longer ranged potentials (8-15A), as confirmed for oxides in PRB 2011 15310
- the Berhler-Parrinello descriptor : A-A, A-B (radial), AAA, AAB (angular) --> scales like N(N+1)/2 and not feasible for > 4 species
- discussed systematic construction of a training set (build prelimenary --> run MD --> compare to DFT)
- It is possible to validate system sizes beyond that which can be reached by DFT, through comparing forces on particular atoms
- the need for transferable formats for ANN potentials (interoperability, data)

- to look up:
  -  PRB 2017 Ceder Artrith: RDF and ADF are expanded as Chebyshev polynomials (after gaussian broadening) so that they form invariant descriptors for a battery material
  - ML for structural prediction and transport properties of amorphous N doped Li3PO4, an electrolyte: Lacivita et al 2018 chemistry of materials.
  - Artrith 2019 JPhysEnergy - good practice / sharing


## Day Two

### Tutorial notes

- in the data folder there is a large (~5000) structure set which can be used as we want
- unsupervised learning can be used for dimensionality reduction
- Dscribe package
- In reality you'd probably use tensorflow (and GPUs) rather than scikitlearn
- There is the use of randomness (see here for where it may creep in: https://machinelearningmastery.com/randomness-in-machine-learning/) which means that re-running with the *same* data and *same* hyperparameters means that different errors are gotten - I'm still not clear on how this should be reported in literature (average? over how many runs?)
- You can break NN with a very simple function: f=xy. 


ABC.py warwick
