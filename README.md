# MASS-CSP
Mining with Answer Set Solving - Contrast Sequential Patterns

## Contents
- folder 'contrast_sequential_mining': sequential contrast pattern mining and condensed representations ASP encoding
- folder 'datasets': ASP encoding of iPRG and UNIX dataset
- folder 'experiments': ASP encoding of iPRG and UNIX sub-datasets used for scalability tests and relative results (pure ASP vs hybrid approach and condensed representations)

### Requirements 
Clingo 5.4.0 for stable models/answer sets.

For running the solution adopted on Windows:
1. Linux subsystem for Windows (Ubuntu 20.04.4) 
2. Download miniconda and after the installation type on Ubuntu terminal the following commands:
''conda create –n potassco –c conda-forge clingo=5.4.0'' then
''conda activate potassco''

For more details about clingo see: https://potassco.org/clingo/

## Datasets
The datasets used are present at the following address: https://dtai.cs.kuleuven.be/CP4IM/cpsm/datasets.html

## Example
From the command line, move to folder contrast_sequential_mining and then type: "clingo instance.lp params.lp frequent_patters.lp contrast_patterns.lp output.lp -n0". Output will be something like that:

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

 If you want to change the working parameters, you will have to add to the command: "clingo instance.lp params.lp sequential_patters.lp contrast_patterns.lp output.lp -c c1=\[class 1 name\] c2=\[class 2 name\] -c th=\[minimum support\] -c mincr=\[minimum contrast rate\] -c minlen=\[minimum pattern length\] -c maxlen=\[maximum pattern length\] -n0"

 For condensed representations: clingo instance.lp params.lp sequential_patters.lp contrast_patterns.lp insertable_fg.lp closed.lp (or maximal.lp) output.lp -c c1=\[class 1 name\] c2=\[class 2 name\] -c th=\[minimum support\] -c mincr=\[minimum contrast rate\] -c minlen=\[minimum pattern length\] -c maxlen=\[maximum pattern length\] -n0 


## Contributors
- Gioacchino Sterlicchio, Dept. of Mechanics, Mathematics and Management, Polytechnic University of Bari
- Prof. Francesca Alessandra Lisi, Dept. of Computer Science, University of Bari


## Citing
- Lisi, F.A., Sterlicchio, G. (2023). Mining Contrast Sequential Patterns with ASP. In: Basili, R., Lembo, D., Limongelli, C., Orlandini, A. (eds) AIxIA 2023 – Advances in Artificial Intelligence. AIxIA 2023. Lecture Notes in Computer Science, vol 14318. Springer, Cham. (https://doi.org/10.1007/978-3-031-47546-7_4).
- Gioacchino Sterlicchio, & Francesca A. Lisi (2024). Condensed Representations for Contrast Sequential Pattern Mining in ASP. In Proceedings of the 39th Italian Conference on Computational Logic, Rome, Italy, June 26-28, 2024. CEUR-WS.org.
