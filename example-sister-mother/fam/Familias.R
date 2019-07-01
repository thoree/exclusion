#Start the Familias package
foo = library(Familias, logical.return=TRUE)
if(!foo)
{install.packages("Familias"); library(Familias)}
#Define the persons involved in the case
persons <- c("1", "2", "3", "4")
sex <- c("male", "female", "female", "female")
#Define the alternative pedigrees
ped1 <- FamiliasPedigree(id=persons, dadid=c(NA,NA,NA,NA), momid=c(NA,NA,NA,"3"), sex=c("male", "female", "female", "female"))
ped2 <- FamiliasPedigree(id=persons, dadid=c(NA,"1","1",NA), momid=c(NA,"4","4",NA), sex=c("male", "female", "female", "female"))
pedigrees <- list(ped1,ped2)
# Define a marker with four alleles with the given frequencies
locus1 <- FamiliasLocus(frequencies=c(0.5000000000,0.5000000000), name="M1", allelenames=c("1","2"), femaleMutationRate = 0, maleMutationRate = 0,femaleMutationRange = 0.1, maleMutationRange = 0.1,femaleMutationRate2 = 0, maleMutationRate2 = 0, maleMutationModel="Equal", femaleMutationModel="Equal")
locus2 <- FamiliasLocus(frequencies=c(0.8000000000,0.2000000000), name="M2", allelenames=c("2","3"), femaleMutationRate = 0, maleMutationRate = 0,femaleMutationRange = 0.1, maleMutationRange = 0.1,femaleMutationRate2 = 0, maleMutationRate2 = 0, maleMutationModel="Equal", femaleMutationModel="Equal")
loci <- list(locus1,locus2)
# List the observed data
datamatrix <- data.frame(locus1.1=c("1",NA,NA,NA), locus1.2=c("2",NA,NA,NA), locus2.1=c("3",NA,NA,NA), locus2.2=c("3",NA,NA,NA))
par(mfrow=c(2,1))
plot(ped1);title("ped1, claim Mother-Daughter")
plot(ped2);title("ped2, true: sisters")
par(mfrow=c(1,1))
#Compute the posteriors and likelihoods
rownames(datamatrix) <- persons
result <- FamiliasPosterior(pedigrees, loci, datamatrix, ref=2)
result
# If the names are not plotted within the limits of the window,
# uncomment and run the following line
# par(mfrow=c(2,1)); plot(ped1,cex=0.5, mar = c(4.1, 2, 4.1, 2), angle=45, density=25);title("claim Mother-Daughter"); plot(ped2,cex=0.5, mar = c(4.1, 2, 4.1, 2), angle=45, density=25);title("true: sisters"); par(mfrow=c(1,1))
