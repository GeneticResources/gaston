### R code from vignette source 'gaston.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: gaston.Rnw:30-31
###################################################
options(continue=" ", prompt = " ", SweaveHooks=list(fig=function() par(mar=c(5.1,4.1,3.1,2.1))), width=90)


###################################################
### code chunk number 2: prompton
###################################################
options(prompt="> ", continue = " ");


###################################################
### code chunk number 3: promptoff
###################################################
options(prompt=" ", continue=" ");


###################################################
### code chunk number 4: gaston.Rnw:42-44
###################################################
options(prompt="> ", continue = " ");
options(width = 90)


###################################################
### code chunk number 5: desc
###################################################
require(gaston)
desc <- packageDescription("gaston")


###################################################
### code chunk number 6: gaston.Rnw:130-132
###################################################
x <- read.bed.matrix( system.file("extdata", "LCT.bed", package="gaston") )
x


###################################################
### code chunk number 7: gaston.Rnw:141-143
###################################################
x <- read.bed.matrix( system.file("extdata", "LCT.bed", package="gaston"), rds = NULL )
x


###################################################
### code chunk number 8: gaston.Rnw:165-168
###################################################
data(TTN)
x <- as.bed.matrix(TTN.gen, TTN.fam, TTN.bim)
x


###################################################
### code chunk number 9: gaston.Rnw:181-184
###################################################
data(TTN)
x <- as.bed.matrix(TTN.gen, TTN.fam, TTN.bim)
slotNames(x)


###################################################
### code chunk number 10: gaston.Rnw:189-190
###################################################
x@bed


###################################################
### code chunk number 11: gaston.Rnw:202-204
###################################################
dim(x@ped)
head(x@ped)


###################################################
### code chunk number 12: gaston.Rnw:215-217
###################################################
dim(x@snps)
head(x@snps)


###################################################
### code chunk number 13: gaston.Rnw:229-234
###################################################
options(gaston.auto.set.stats = FALSE)
data(TTN)
x <- as.bed.matrix(TTN.gen, TTN.fam, TTN.bim)
head(x@ped)
head(x@snps)


###################################################
### code chunk number 14: gaston.Rnw:241-243
###################################################
x <- set.stats(x)
head(x@ped)


###################################################
### code chunk number 15: gaston.Rnw:255-256
###################################################
head(x@snps)


###################################################
### code chunk number 16: gaston.Rnw:270-273
###################################################
str(x@p)
str(x@mu)
str(x@sigma)


###################################################
### code chunk number 17: gaston.Rnw:282-285
###################################################
getOption("SweaveHooks")[["fig"]]()
plot(x@p, x@sigma, xlim=c(0,1))
t <- seq(0,1,length=101);
lines(t, sqrt(2*t*(1-t)), col="red")


###################################################
### code chunk number 18: gaston.Rnw:301-308
###################################################
head(x@p)
y <- x[1:30,]
head(y@p)
y <- set.stats(y, set.p = FALSE)
head(y@p)
y <- set.stats(y)
head(y@p)


###################################################
### code chunk number 19: gaston.Rnw:322-323
###################################################
options(gaston.auto.set.stats = TRUE)


###################################################
### code chunk number 20: gaston.Rnw:333-335
###################################################
x[1:100,]
x[1:100,10:19]


###################################################
### code chunk number 21: gaston.Rnw:341-342
###################################################
x[,x@snps$maf > 0.1]


###################################################
### code chunk number 22: gaston.Rnw:350-352
###################################################
x <- set.hwe(x)
select.snps(x, maf > 0.1 & hwe > 1e-3)


###################################################
### code chunk number 23: gaston.Rnw:384-392
###################################################
data(AGT)
x1 <- as.bed.matrix(AGT.gen, AGT.fam, AGT.bim)
x1
data(LCT)
x2 <- as.bed.matrix(LCT.gen, LCT.fam, LCT.bim)
x2
x <- cbind(x1,x2)
x


###################################################
### code chunk number 24: gaston.Rnw:399-402
###################################################
x3 <- x[1:10, ]
x4 <- x[-(1:10), ]
rbind(x3,x4)


###################################################
### code chunk number 25: gaston.Rnw:419-422
###################################################
x <- as.bed.matrix(TTN.gen, TTN.fam, TTN.bim)
X <- as.matrix(x)
X[1:5,1:4]


###################################################
### code chunk number 26: gaston.Rnw:427-429
###################################################
standardize(x) <- "mu"
as.matrix(x)[1:5, 1:4] 


###################################################
### code chunk number 27: gaston.Rnw:433-434
###################################################
scale(X)[1:5,1:4]


###################################################
### code chunk number 28: gaston.Rnw:439-442
###################################################
standardize(x) <- "p"
as.matrix(x)[1:5, 1:4] 
scale(X, scale = sqrt(2*x@p*(1-x@p)))[1:5,1:4]


###################################################
### code chunk number 29: gaston.Rnw:456-457
###################################################
y <- x %*% c(rep(0,350),0.25,rep(0,ncol(x)-351)) + rnorm(nrow(x), sd = 1)


###################################################
### code chunk number 30: gaston.Rnw:484-488
###################################################
x <- read.bed.matrix( system.file("extdata", "chr2.bed", package="gaston") )
x
head(x@ped)
table(x@ped$population)


###################################################
### code chunk number 31: gaston.Rnw:495-500
###################################################
K <- GRM(x)

eiK <- eigen(K)
# deal with a small negative eigen value
eiK$values[ eiK$values < 0 ] <- 0


###################################################
### code chunk number 32: gaston.Rnw:509-512
###################################################
getOption("SweaveHooks")[["fig"]]()
PC <- sweep(eiK$vectors, 2, sqrt(eiK$values), "*")
plot(PC[,1], PC[,2], col=x@ped$population)
legend("bottomleft", pch = 1, legend = levels(x@ped$population), col = 1:5)


###################################################
### code chunk number 33: gaston.Rnw:526-530
###################################################
# one can use PC[,1:2] instead of eiK$vectors[,1:2] as well
L <- bed.loadings(x, eiK$vectors[,1:2])
dim(L)
head(L)


###################################################
### code chunk number 34: gaston.Rnw:534-535
###################################################
colSums(L**2)


###################################################
### code chunk number 35: gaston.Rnw:540-543
###################################################
standardize(x) <- 'p'
head( (x %*% L) / sqrt(ncol(x)-1) )
head( PC[,1:2] )


###################################################
### code chunk number 36: gaston.Rnw:563-571
###################################################
data(AGT)
x <- as.bed.matrix(AGT.gen, AGT.fam, AGT.bim)

ld.x <- LD(x, c(1,ncol(x)))

LD.plot(ld.x, snp.positions = x@snps$pos, write.ld = NULL, 
        max.dist = 20e3, write.snp.id = FALSE, draw.chr = FALSE, 
        pdf = "LD_AGT.pdf")


###################################################
### code chunk number 37: gaston.Rnw:581-583
###################################################
y <- LD.thin(x, threshold = 0.4, max.dist = 500e3)
y


###################################################
### code chunk number 38: gaston.Rnw:590-592
###################################################
ld.y <- LD( y, lim = c(1, ncol(y)) )
sum( ld.y > 0.4 )


###################################################
### code chunk number 39: gaston.Rnw:628-633
###################################################
set.seed(1)
n <- 100
q1 <- 20
Z1 <- matrix( rnorm(n*q1), nrow = n )
X <- cbind(1, 5*runif(n))


###################################################
### code chunk number 40: gaston.Rnw:639-641
###################################################
u1 <- rnorm(q1, sd = sqrt(2))
y <- X %*% c(1,2) + Z1 %*% u1 + rnorm(n, sd = sqrt(3))


###################################################
### code chunk number 41: gaston.Rnw:648-652
###################################################
q2 <- 10
Z2 <- matrix( rnorm(n*q2), nrow = n ) 
u2 <- rnorm(q2, sd = 1)
y2 <- X %*% c(1,2) + Z1 %*% u1 + Z2 %*% u2 + rnorm(n, sd = sqrt(3))


###################################################
### code chunk number 42: gaston.Rnw:665-668
###################################################
K1 <- tcrossprod(Z1)
fit <- lmm.aireml(y, X, K = K1, verbose = FALSE)
str(fit)


###################################################
### code chunk number 43: gaston.Rnw:683-687
###################################################
getOption("SweaveHooks")[["fig"]]()
par(mfrow = c(1, 2))
plot(Z1 %*% u1, fit$BLUP_omega); abline(0, 1, lty = 2, col = 3)
BLUP_u1 <- fit$tau * t(Z1) %*% fit$Py
plot(u1, BLUP_u1); abline(0, 1, lty = 2, col = 3)


###################################################
### code chunk number 44: gaston.Rnw:696-699
###################################################
K2 <- tcrossprod(Z2)
fit2 <- lmm.aireml(y2, X, K = list(K1, K2), verbose = FALSE)
str(fit2)


###################################################
### code chunk number 45: gaston.Rnw:708-713
###################################################
getOption("SweaveHooks")[["fig"]]()
par(mfrow = c(1, 2))
omega1 <- fit2$tau[1] * K1 %*% fit2$Py
omega2 <- fit2$tau[2] * K2 %*% fit2$Py
plot(Z1 %*% u1, omega1); abline(0, 1, lty = 2, col = 3)
plot(Z2 %*% u2, omega2); abline(0, 1, lty = 2, col = 3)


###################################################
### code chunk number 46: gaston.Rnw:740-743
###################################################
eiK1 <- eigen(K1)
fit.d <- lmm.diago(y, X, eiK1)
str(fit.d)


###################################################
### code chunk number 47: gaston.Rnw:753-757
###################################################
getOption("SweaveHooks")[["fig"]]()
TAU <- seq(0.5,2.5,length=50)
S2 <- seq(2.5,4,length=50)
lik <- lmm.diago.likelihood(tau = TAU, s2 = S2, Y = y, X = X, eigenK = eiK1)
lik.contour(TAU, S2, lik, heat = TRUE, xlab = "tau", ylab = "sigma^2")


###################################################
### code chunk number 48: gaston.Rnw:790-794
###################################################
set.seed(1)
n <- 2000
R <- random.pm(n)
y <- 2 + lmm.simu(tau = 1, sigma2 = 2, eigenK = R$eigen)$y


###################################################
### code chunk number 49: gaston.Rnw:799-800
###################################################
fit <- lmm.diago(y, eigenK = R$eigen)


###################################################
### code chunk number 50: gaston.Rnw:803-804
###################################################
h2 <- fit$tau/(fit$tau + fit$sigma)


###################################################
### code chunk number 51: gaston.Rnw:814-817
###################################################
getOption("SweaveHooks")[["fig"]]()
H2 <- seq(0,1,length=51)
lik <- lmm.diago.likelihood(h2 = H2, Y = y, eigenK = R$eigen)
plot(H2, exp(lik$likelihood-max(lik$likelihood)), type="l", yaxt="n", ylab="likelihood")


###################################################
### code chunk number 52: gaston.Rnw:825-827
###################################################
PC <- sweep(R$eigen$vectors, 2, sqrt(R$eigen$values), "*")
y1 <- 2 + PC[,1:2] %*% c(5,5) + lmm.simu(tau = 1, sigma2 = 2, eigenK = R$eigen)$y


###################################################
### code chunk number 53: gaston.Rnw:831-835
###################################################
fit0 <- lmm.diago(y1, eigenK = R$eigen)
fit0$tau/(fit0$tau+fit0$sigma2)
fit10 <- lmm.diago(y1, eigenK = R$eigen, p = 10)
fit10$tau/(fit10$tau+fit10$sigma2)


###################################################
### code chunk number 54: gaston.Rnw:864-867
###################################################
data(AGT)
x <- as.bed.matrix(AGT.gen, AGT.fam, AGT.bim)
standardize(x) <- 'mu'


###################################################
### code chunk number 55: gaston.Rnw:871-873
###################################################
set.seed(1)
R <- random.pm(nrow(x))


###################################################
### code chunk number 56: gaston.Rnw:877-879
###################################################
y <- 2 + x %*% c(rep(0,350),0.25,rep(0,ncol(x)-351)) +
     lmm.simu(tau = 0.3, sigma2 = 1, eigenK=R$eigen)$y


###################################################
### code chunk number 57: gaston.Rnw:885-888
###################################################
getOption("SweaveHooks")[["fig"]]()
t_score <- association.test(x, y, K = R$K, method = "lmm")
t_wald <- association.test(x, y, eigenK = R$eigen, method = "lmm", test = "wald")
plot( t_score$p, t_wald$p, log = "xy", xlab = "score", ylab = "wald")


###################################################
### code chunk number 58: gaston.Rnw:895-897
###################################################
getOption("SweaveHooks")[["fig"]]()
plot(-log10(t_score$p), xlab="SNP index", ylab = "-log(p)",
      col = c(rep(1,350),2,rep(1,ncol(x)-351)))


###################################################
### code chunk number 59: gaston.Rnw:906-908
###################################################
getOption("SweaveHooks")[["fig"]]()
lds <- LD(x, 351, c(1,ncol(x)))
plot(lds, -log10(t_score$p), xlab="r^2", ylab="-log(p)")


###################################################
### code chunk number 60: gaston.Rnw:919-924
###################################################
getOption("SweaveHooks")[["fig"]]()
y1 <- as.numeric(y > mean(y))
t_binary <- association.test(x, y1, K = R$K, method = "lmm", response = "binary")
# (mini) Manhattan plot
plot(-log10(t_binary$p), xlab="SNP index", ylab = "-log(p)",
      col = c(rep(1,350),2,rep(1,ncol(x)-351)))


