model{
  
  for (i in 1:n.stocks){
    
  # censoring mechanism  
  censored[i] ~ dinterval(a.time[i],ctime[i])
  
  # sampling model
  a.time[i] ~ dweib(tau,mu[i])
  
  # linear predictor
  log(mu[i]) <- betas[1:n.covs] %*% COVS[i,1:n.covs] + habitat[hab[i]] + family[fam[i]]
  
  # cox-snell residuals - use pweib alone for predictions of P(t<T|X) i.e. for some predictor X what is the probability that a stock is assessed within T years
  CS[i] <- -log(1-pweib(ctime[i],tau,mu[i]))
  
  
  
  }
  
  # regression parameters
  for (k in 1:n.covs){
    betas[k] ~ dnorm(0,1e-6)
  }
  
  ###
  #random effects 
  ###
  
  for (j in 1:n.hab){
    habitat[j] <- hab.xi*hab.eta[j]
    hab.eta[j] ~ dnorm(0,hab.prec)
  }
  # half cauchy prior on random effect variance
  hab.xi ~ dnorm(0,0.04)
  hab.prec ~ dgamma(0.5,0.5)
  
  for (l in 1:n.fam){
    family[l] <- fam.xi*fam.eta[l]
    fam.eta[l] ~ dnorm(0,fam.prec)
  }
  # finite population variance
  fp.var <- sd(family)
  
  # half cauchy on random effects
  fam.xi ~ dnorm(0,0.04)
  fam.prec ~ dgamma(0.5,0.5)
  
  tau ~ dgamma(0.1,0.1)
  
}