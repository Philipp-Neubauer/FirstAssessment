model{
  
  for (i in 1:n.stocks){
    
  # censoring mechanism  
  censored[i] ~ dinterval(a.time[i],ctime[i])
  
  # sampling model
  a.time[i] ~ dweib(tau,mu[i])
  
  # linear predictor
  mu[i] <- exp(betas[1:n.covs] %*% COVS[i,1:n.covs] + habitat[hab[i]] + classfx[class[i]] + familyfx[family[i]] + orderfx[order[i]])
  
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
  hab.xi ~ dnorm(0,0.001)
  hab.prec ~ dgamma(0.5,0.5)
  
  for (l in 1:n.class){
    classfx[l] <- class.xi*class.eta[l]
    class.eta[l] ~ dnorm(0,class.prec)
  }
  # finite population variance
  fp.sd.class <- sd(classfx)
  fp.sd.hab <- sd(habitat)
  
  # half cauchy on random effects
  class.xi ~ dnorm(0,0.001)
  class.prec ~ dgamma(0.5,0.5)
  
  for (l in 1:n.order){
    orderfx[l] <- order.xi*order.eta[l]
    order.eta[l] ~ dnorm(0,order.prec)
  }
  # finite population variance
  fp.sd.order <- sd(orderfx)
  
  # half cauchy on random effects
  order.xi ~ dnorm(0,0.001)
  order.prec ~ dgamma(0.5,0.5)
  
  for (l in 1:n.family){
    familyfx[l] <- family.xi*family.eta[l]
    family.eta[l] ~ dnorm(0,family.prec)
  }
  # finite population variance
  fp.sd.family <- sd(familyfx)
  
  # half cauchy on random effects
  family.xi ~ dnorm(0,0.001)
  family.prec ~ dgamma(0.5,0.5)
  
  tau ~ dgamma(0.00001,0.00001)
  
}