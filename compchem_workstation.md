**What should I look for in a VASP workstation/cluster?**

*What kind of calculations do I want to do?*

It'd be really nice to have something for phonon calculations on defect systems. For example, single kpoint calculations of 192 atoms.

Max cores is equal to kpts\*num_bands but for better efficiency it is typically kpts*(num_bands/4). 
An atom has typically 4 bands so for a 192 atom system (a rough lower bound for defects in hybrid materials) and a single kpoint, 48 cores are needed. 

Northumbria University has a machine that could handle this BUT this would be a very time intensive calculation; investing in a small cluster might be desirable.
Would also open up the possibility of doing some time-intensive MD runs...

*What compute resources are needed for these?*

- type of CPU --> intel (VASP is very reliant on Intel’s Fortran compiler). Archer has Intel Xeon E5-2697 v2 (ivy bridge), Larsson reports that the Xeon E5-2600 series (2650 and 2660 models) give the low clock frequency/high RAM tradeoff that we're looking for with VASP calcs. 
Jonathan reports that Vasp runs significantly more efficiently with the newer intel skylake processors.
- number of cores --> determined by the number of atoms in your system (and number of kpoints). Note that hyperthreading is not effective for running VASP calculations. Ideally 48 cores. Could still do some useful calcs with 24..
- RAM: important to have sufficient clock speed (DDR3 or DDR4). 4GB/core is ideal, for handling hybrid functionals. As a point of reference, Archer has 24 physical cores per node, 64GB RAM per node or 128GB for the largmemory nodes
- clock frequency: This is not as important as memory, which is the limiting factor for VASP calculations. 
- storage: hybrid SSD and HDD drives give good speed and capacity. From specs for the Walsh group Curie machine, could look for something in the region of 7TB HDD, SSD 250GB
- are there other things that I'm missing?

*To what extent would the above translate to other DFT codes?*
- I don't have a feel for this; my gut is that other DFT codes would have similar computational demands.

*Is it worth considering GPUs?*

From my experience using GPU nodes on Piz Daint, the NSIM needed tweaking for each system adding another layer of tests, and LREAL=False not being supported was a real pain: I needed to set ROPT low and ran into memory issues.

*Ok, I know what I'd like: how do I procure it?*

- have others been forced to use university procurement for lab equipment?
- if not, which vendors can you recommend?
- have people built their own workstations up (ie, got motherboard, fitted in extra memory, networking cards etc)? (I find this a very daunting idea)

Links
-----
https://www.pdc.kth.se/software/software/VASP/crayos7/5.4.4-vanilla/index_using.html
https://www.nsc.liu.se/~pla/blog/2013/09/04/hardware-for-vasp




