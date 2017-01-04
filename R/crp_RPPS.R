













#-----------------------------------------------
#
# função auxiliar 1 - captura conteúdo da pagina
#
#-----------------------------------------------
captura_pagina <- function(cnpj){
     #
     # cnpj - CNPJ do Município
     #
     url_base <- "http://www1.previdencia.gov.br/sps/app/crp/ExtratoRegularidadeRegimes.asp?"
     cnpj <- paste("CD_CNPJ=", cnpj, sep="")
     tempo <- paste("&time=", strsplit(as.character(Sys.time()), split=" ")[[1]][2], sep="")
     relatorio <- "&Rel=N-L-R-D-S-E-P"
     txt <- readLines(paste(url_base, cnpj, tempo, relatorio, sep=""))
     txt 
}

#------------------------------------------------------------
#
# função auxliar 2 - captura dados relativos ao número do CRP
#
#------------------------------------------------------------
capturaCRP <- function(txt){
     #
     # x - arquivo html contendo dados do extrato previdenciário
     #
     #tt <- readLines(x)
     tt <- try(grep("CRP VIGENTE|Último CRP|CRP", txt, value=TRUE))
     tt <- unlist(strsplit(tt, ","))
     tt[1] <- gsub(".*(\\d{6}-[[:digit:]]+).*",  "\\1", tt[1])
     tt[2] <- gsub(".*(\\d{2}/\\d{2}/\\d{4}).*", "\\1", tt[2])
     tt[3] <- gsub(".*(\\d{2}/\\d{2}/\\d{4}).*", "\\1", tt[3])
     names(tt) <- c("CRP", "DtEmissao", "DtValidade")
     tt
}


#----------------------------------------------
#
# função auxiliar 3 - extrai conteúdo da página
#
#----------------------------------------------
extrai_dados_extrato <- function(txt){
     #
     # txt - conteúdo da página html
     #
     if(!require(XML)) stop("O pacote XML não está instalado")
     tabelas <- readHTMLTable(txt)
     dados.crp <- capturaCRP(txt)
     municipio <- c(Municipio = as.character(tabelas[[1]][1,]))
     tabelas <- tabelas[[3]][, 2]
     tabelas <- as.character(tabelas)
     names(tabelas) <- c(paste("V", 1:length(tabelas), sep="")) 
     tabelas <- c(municipio, dados.crp, tabelas)
     tabelas <- iconv(tabelas,'UTF-8','latin1')
     tabelas     
}


