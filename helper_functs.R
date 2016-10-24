get_coef_chains <- function(model.out,coef.names=NULL,var.names=NULL){
  
  if(length(model.out)>1){
    model.post <- do.call('rbind',model.out)
  } else {
    model.post <- unclass(model.out[[1]])
  }
  if(length(grep(coef.names,colnames(model.post)))==1) {
    chains <- data.frame(model.post[,grep(substitute(coef.names),colnames(model.post))])
  } else if (any(coef.names %in% colnames(model.post))){
    chains <- model.post[,coef.names]
  } else {
    chains <- model.post[,grep(coef.names,colnames(model.post))]
  }
  if(!is.null(var.names)) colnames(chains) <- var.names
  if (dim(chains)[2]>1) {
    chains <- reshape2::melt(chains)[,2:3]
    colnames(chains) <- c('Parameter','MCMC')
  } else {
    colnames(chains) <- 'MCMC'
  }
  return(chains)
}