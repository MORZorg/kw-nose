kw-nose
=======

A Leading-by-Nose implementation for Kawasaki robots.

####Files
This folder contains the following files:

* **LICENSE**: GNU general public license  
* **Relazione.docx**: report of the work we have done in word format
* **Relazione.pdf**: report of the work we have done in pdf format
* **morz_follow.as**: program which move the Kawasaki robot, following the received data
* **morz_pc_gen.as**: pc_program which produces simulated data needed for morz_follow.as  
* **morz_pc_mgen.as**: pc_program which produces simulated transational velocity needed for morz_follow.as
* **morz_pc_rgen.as**: pc_program which produces simulated rotational velocity needed for morz_follow.as

####How to use
For the execution in a testing mode, you have to call the pc program with the following command:
*pcexec morz_pc_gen*

Then, to make the robot moves, you have to call the program with the following command:
*exec morz_follow*
