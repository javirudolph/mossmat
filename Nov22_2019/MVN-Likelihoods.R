library(mvtnorm)



# Likelihood function for the hypothesis that the covariances
# for males are identical to the covariances for females (Null model)
Cov.like <- function(params,males.data, fems.data){
	
	sig21 <- params[1]
	sig12 <- sig21
	
	sigsq <- exp(params[2])
	
	all.data <- rbind(males.data,fems.data)
	
	mu.hats <- apply(all.data,2,mean)
	p <- length(mu.hats)
	n <- nrow(all.data)
	
	cov.mat <- matrix(0,nrow=p,ncol=p)
	
	cov.mat[1,1] <- sigsq
	cov.mat[2,2] <- sigsq
	cov.mat[2,1] <- sig21
	cov.mat[1,2] <- sig12
 	
	llikes <- rep(0,n)
	
	for(i in 1:n){
		
		llikes[i] <- dmvnorm(x=all.data[i,], mean=mu.hats, sigma=cov.mat,log=TRUE)
	}
	
	negll <- -sum(llikes)
	
	return(negll)
}


# Likelihood function for the hypothesis that the covariances
# for males are identical to the covariances for females (Null model)
Cov.like.alt <- function(params,males.data, fems.data){
	
	sig21 <- params[1]
	sig12 <- sig21
	
	sigsq <- exp(params[2])
	
	all.data <- rbind(males.data,fems.data)
	
	mu.hats <- apply(all.data,2,mean)
	p <- length(mu.hats)
	n <- nrow(all.data)
	
	cov.mat <- matrix(0,nrow=p,ncol=p)
	
	cov.mat[1,1] <- sigsq
	cov.mat[2,2] <- sigsq
	cov.mat[2,1] <- sig21
	cov.mat[1,2] <- sig12
 	
	llikes <- rep(0,n)
	
	for(i in 1:n){
		
		llikes[i] <- dmvnorm(x=all.data[i,], mean=mu.hats, sigma=cov.mat,log=TRUE)
	}
	
	negll <- -sum(llikes)
	
	return(negll)
}




###### simulate a sample of size 20 with a given mean and covariance matrix.
###### Assume that: 1) 10 first obs. are males, second set of 10 obs are females
###### and since all samples were simulated with the same covariance, then assume that
###### there is no difference in covariances between males and females
######  (In other words, I'm simulating from a null hypothesis of sorts...)

muvec <- c(0,0) # dimension = 2
Sigma <- matrix(c(0.3,0.1,0.1,0.4), nrow=2,ncol=2,byrow=TRUE)
print(Sigma) # print the variance covariance matrix


n <- 20
sim.sample <- rmvnorm(n = n,mean = muvec,sigma = Sigma) 

males.samps <- sim.sample[1:10,]
fems.samps  <- sim.sample[11:20,]

###  Checking that the neg-llikelihood function works
Cov.like(params= c(0.15,log(0.3)), males.data=males.samps, fems.data=fems.samps)


### Finding the best values (MLES) for sig12, sig21 and the variances

optim.trial <- optim(par=c(0.15,log(0.3)), fn=Cov.like, method="Nelder-Mead",  males.data=males.samps, fems.data=fems.samps)

sig12.mle <- optim.trial$par[1]
sigsq.mle <- exp(optim.trial$par[2])

# So your mle for the covariance matrix is:

cov.mle <- matrix(0,nrow=2,ncol=2)

diag(cov.mle) <- rep(sigsq.mle,2)
cov.mle[1,2] <- cov.mle[2,1] <- sig12.mle

print(cov.mle)


### And the BIC score for that null model is
### -2*llikelihood + p*log(n)

BIC.null <- 2*optim.trial$value + 2*log(20)








