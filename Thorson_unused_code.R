
# Attempt to replicate Fig. 2
AssessDF = matrix( nrow=nrow(unique(full.tab[,'stock'])), ncol=5)
for(rowI in 1:nrow(AssessDF)){
  AssessDF[rowI,1] = as.character(unique(full.tab[,'stock'])[rowI,1])
  Tmp = full.tab[ which(full.tab[,'stock']==AssessDF[rowI,1]), ]
  AssessDF[rowI,2] = as.character( Tmp[1,'mainregion'] )
  AssessDF[rowI,3] = as.numeric(Tmp[1,'year'])
  AssessDF[rowI,4] = as.numeric(Tmp[1,'Year.of.fishery.development..stock.based.'])
  AssessDF[rowI,5] = as.numeric(Tmp[1,'Year.of.first.stock.assessment'])
}

tapply( AssessDF[,5], INDEX=AssessDF[,2], FUN=function(vec){mean(!is.na(vec))})

