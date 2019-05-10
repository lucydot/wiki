## Curated notes ML4MS

### big picture
- big picture: the preparation, synthesis, characterisation of materials is costly and complex, there is a huge collection of known inorganic materials listed on Springer but most properties are not known
- the training --> descriptor --> learning --> prediction loop
- ML is where x/y pairs are fed to a learning scheme, which is tuned by hyperparameters, so that it can be used to perform tasks on new data.
- ML built on top of ab-initio calculations
- usually we use ML when the laws are unknown. But in MS we know the laws! But the model is complex. So the ideas is to find descriptors which embed enough physical information so that the model itself is easy enough to solve. Smaller training sets (100s) are possible if the correct descriptor and method is used (eg: ghiringhelli's work predicting xtal structure from composition)
- may become as ubiquitous in science as numerical simulation or calculus (nature coment Lenka Zdebarova)
- ML can enable new science as it allows us to bypass calculations which would be unfeasible.
- ML must be done with domain expertise to a) access and verify the quality of data b) select descriptors which reflect underlying physics c) pose an interesting question d) interpret the output: sanity checks and for understanding
- Now at a point that ML trained on CC can beat DFT (Ceriotti work)
- trial and error vs high throughput vs inverse design
- how does inverse design link to this project? Can find the intercalation levels where defect levels are dangerous - these are the regions we want to avoid.
-  machine learning algorithms can be used decrease the role of intuition in model building

### more detail
- much can be done with course grained models - where the exact positions are not the deciding factor but the topology (connectivity) - eg: Nomad kaggle where winner was dressed chemical species for predicting TCO (which included band gap, eg: energy levels) - this showed that the local topology is more important than the exact angles.
- cluster expansion only considers grouping of 2/3 etc but removing the requirement of linearity through NN results in higher order interactions
- ML can be used for interpolation. If you have a set of reference calculations, and you believe there is a continous PES, then interpolate so that MD/MC can be done
- methods are not automatically invariant to rotation or permnutational invariance. This must be built into the descriptor.
- Descriptors which include all atomic positions quickly become infeasible for a larger number of species (>4 atoms), see Berhler-Parrinello descriptor which scales like N(N+1)/2
- Artrith's work has shown that it is possible to account for longer range electrostatic interactions (up to 15A) using local (additive) terms (PRB 2011 15310)
- An important aspect of the workflow is the systematic construction of a training set (build prelimenary-->run MD on new candidate-->compare to DFT)
- Previous work around ML on battery material from Ceder Artrith PRB 2017, where Chebyshev polynomials are applied to a RDF after gaussian broadening. This provides the correct invariance.
- ML can be split into supervised and unsupervised learning. Unsupervised learning is often use as an initial step for dimensionality reduction.
- Increasing the number of neural net parameters means increasing the amount of training data needed. 
- We should distinguish between extensive and intensive properties - energy vs HOMO/LUMO
- tensorflow / keras rather than scikitlearn
- one of the benefits of ML in MS is that we have the underlying physics which provides a lot of constraints. This is not true for people trying to ML pictures of kittens!
- we cannot represent structure using cartesian coordinates as they don't obey fundamental physical symmetries: exchange of identical atoms (permutational variance), rotation
- ML is not just about interpolation: it can also tell us about the multiscale aspect of a problem. For example, learning curve as a function of locality (cutoff) can tell us over which scales the important physics plays a part.
- work from Sluydts shows that ML applied to defect properties is possible, but has been restricted to simple system (Si). Can move from simulation of 3 vacancies to simulate enrgy/forces on 13 vacancies.
- ensemble methods (like gaussian process) can give you a measure for uncertainty
- it is best to use end-to-end learning where we can control the input parameters (this is not done with CE: better to go direct?)
- Jacobsens work on graph neural networks shows that when describing using topology, a more complex material can achieve better results! As less complex is harder to differentiate.

### wider motivations
- reproduciblity is especially important in fields like ML where it is a challenge, in due part to randomness: https://openlab-flowers.inria.fr/t/how-many-random-seeds-should-i-use-statistical-power-analysis-in-deep-reinforcement-learning-experiments/457
- use of GPUs which I have some experience with


To read:
	- 2014 PRB Mueller, hole trapping depth
	- 2013 vidvudis ozilins, cluster expansion "compressive sampling as a paradigm for building physics models" (this seems important)
	- Artrith PRB 2011 15310
	- PRB 2017 Ceder Artrith - battery material
	- Li3PO$ electrolyte, amorphous, Lacivita 2018 Chemistry of Materials
	- good practice explored in 2019 JPhysEnergy (couldnt' find)
	- Willatt JCP 2019 
	- Drautz PRB 2019 (couldnt access but there)
	- Cerriotti DFT beating work

"the formation energies of multicomponentalloys can be efficiently parameterized using generalized Isingmodels (cluster expansions) with a finite number of pair andmultibody interactions.7–9In all these cases, enormous gainsin efficiency and conceptual clarity are achieved by buildingmodels  that  express  the  quantity  of  interest  (typically,  totalenergy) in a simple, easy-to-evaluate functional form. Thesemodels can then be used to perform realistic simulations atfinite temperatures, on large systems, and/or over long timescales,  significantly  extending  the  reach  "

