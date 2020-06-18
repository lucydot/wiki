**What should I look for in a VASP workstation/cluster?**

*What kind of calculations do I want to do?*

Highthroughput type - calculations that can be split into smaller jobs but that need to be repeated many *many* times. For example - phonon calculations on defect systems, MD, site-disordered systems.
Max cores is equal to kpts\*num_bands but for better efficiency it is typically kpts*(num_bands/4). 
An atom has typically 4 bands so for a 96 atom system (a rough lower bound of the supercell size for defects in hybrid materials) and a single kpoint, 24 cores are needed. 

Northumbria University has a machine that could handle this system size BUT these calculations are very time intensive calculation; a single calculation could take weeks to run. Having a dedicated computer should also make it easier for masters students / summer students etc to get short term access to a decent machine.

*What compute resources are needed for these?*

- type of CPU --> intel (VASP is very reliant on Intel’s Fortran compiler). Archer has Intel Xeon E5-2697 v2 (ivy bridge), Larsson reports that the Xeon E5-2600 series (2650 and 2660 models) give the low clock frequency/high RAM tradeoff that we're looking for with VASP calcs. 
Jonathan reports that Vasp runs significantly more efficiently with the newer intel skylake processors.
- number of cores --> determined by the number of atoms in your system (and number of kpoints). Note that hyperthreading is not effective for running VASP calculations. Ideally 24 cores. 
- RAM: important to have sufficient clock speed (DDR3 or DDR4). 4GB/core is ideal, for handling hybrid functionals. As a point of reference, Archer has 24 physical cores per node, 64GB RAM per node or 128GB for the largmemory nodes
- clock frequency: This is not as important as memory, which is the limiting factor for VASP calculations. 
- storage: hybrid SSD and HDD drives give good speed and capacity. From specs for the Walsh group Curie machine, could look for something in the region of 7TB HDD, SSD 250GB

*Is it worth considering GPUs?*

From my experience using GPU nodes on Piz Daint, the NSIM needed tweaking for each system adding another layer of tests, and LREAL=False not being supported was a real pain: I needed to set ROPT low and ran into memory issues.

Links
-----
https://www.pdc.kth.se/software/software/VASP/crayos7/5.4.4-vanilla/index_using.html
https://www.nsc.liu.se/~pla/blog/2013/09/04/hardware-for-vasp
https://zworkstations.com/products/



