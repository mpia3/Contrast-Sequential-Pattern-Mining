# Contrast-Sequential-Pattern-Mining
A declarative approach to Sequential Contrast Pattern Mining in Answer Set Programming (ASP)

## Contents
- folder 'contrast_sequential_mining': sequential contrast pattern mining ASP encoding
- folder 'datasets': ASP encoding of iPRG and UNIX dataset
- folder 'experiments': ASP encoding of iPRG and UNIX sub-datasets used for scalability tests

### Requirements 
Clingo 5.4.0 for stable models/answer sets.

For running the solution adopted on Windows:
1. Linux subsystem for Windows (Ubuntu 20.04.4) 
2. Download miniconda and after the installation type on Ubuntu terminal the following commands:
''conda create –n potassco –c conda-forge clingo=5.4.0'' then
''conda activate potassco''

For more details about clingo see: https://potassco.org/clingo/

## Example
from the command line, move to folder contrast_sequential_mining and then type: "clingo istance.lp params.lp frequent_patters.lp contrast_patterns.lp output.lp -n0". Output will be something like that:

"clingo version 5.4.0  
 Reading from istance.lp ...  
 Solving...  
 Answer: 1  
 pat(1,b) pat(2,c) growth_rate("0.375",c1) growth_rate("2.6666666666666665",c2) contrast_pattern(no,c1) contrast_pattern(yes,c2)    
 Answer: 2  
 pat(1,a) pat(2,b) growth_rate("0.375",c1) growth_rate("2.6666666666666665",c2) contrast_pattern(no,c1) contrast_pattern(yes,c2)  
 Answer: 3  
 pat(1,a) pat(2,b) pat(3,c) growth_rate("0.375",c1) growth_rate("2.6666666666666665",c2) contrast_pattern(no,c1) contrast_pattern(yes,c2)  
 SATISFIABLE  

 Models       : 3  
 Calls        : 1  
 Time         : 0.082s (Solving: 0.00s 1st Model: 0.00s Unsat: 0.00s)  
 CPU Time     : 0.045s"  

 If you want to change the working parameters, you will have to add to the command: "clingo istance.lp params.lp frequent_patters.lp contrast_patterns.lp output.lp -c c1=\[class 1 name\] c2=\[class 2 name\] -c th=\[minimum support\] -c mincr=\[minimum contrast rate\] -c minlen=\[minimum pattern length\] -c maxlen=\[maximum pattern length\] -n0"


## Project team
- Gioacchino Sterlicchio, Dept. of Mechanics, Mathematics and Management, Polytechnic University of Bari
- Prof. Francesca Alessandra Lisi, Dept. of Computer Science, University of Bari
