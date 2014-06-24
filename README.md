kw-nose
=======

A Leading-by-Nose implementation for Kawasaki robots.

##Files
This folder contains the following files:
 * **LICENSE**: GNU general public license  
 * **Relazione.docx**: report of the work we have done in word format
 * **Relazione.pdf**: report of the work we have done in pdf format
 * **morz_follow.as**: program which move the Kawasaki robot, following the received data
 * **morz_pc_gen.as**: PC program which produces simulated data, both translational and rotational, needed for `morz_follow.as`  
 * **morz_pc_mgen.as**: PC program which produces simulated translational velocity needed for `morz_follow.as`
 * **morz_pc_rgen.as**: PC program which produces simulated rotational velocity needed for `morz_follow.as`

##How to use
For the execution with simulated data, you have to execute one of the following PC programs:

	pcexec morz_pc_gen

or

	pcexec morz_pc_mgen

or

	pcexec morz_pc_rgen

or for the execution with real data (file not included here):

	pcexec qggp_sensorUDP

finally, to make the robot move, you have to call the program:

	exec morz_follow

##Authors:
 * Marco Maddiona
 * Riccardo Orizio
 * Mattia Rizzini
 * Maurizio Zucchelli
