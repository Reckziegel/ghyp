"qqghyp" <- function(object,data=ghyp.data(object),
                   gaussian=T,line=T,
                   main="Generalized Hyperbolic Q-Q Plot",
                   xlab="Theoretical Quantiles",ylab="Sample Quantiles",
                   ghyp.pch = 1,gauss.pch=6,ghyp.lty="solid",
                   gauss.lty="dashed",ghyp.col="black",
                   gauss.col="black",
                   plot.legend=T,location="topleft",legend.cex=0.8,
                   spline.points=150,
                   root.tol = .Machine$double.eps^0.5,
                   rel.tol = root.tol,abs.tol = root.tol^1.5,
                   ...)
{
  test.ghyp(object, case = "univariate")
  
  data <- check.data(data, case = "uv", na.rm = T, fit = TRUE, dim = 1)
  
  ## compute quantiles   

  ghyp.p <- seq(1/length(data), 1 - 1/length(data), length = length(data))

  ghyp.q <- qghyp(ghyp.p,object, method = "splines",
                  spline.points = spline.points, root.tol = root.tol,
                  rel.tol = rel.tol, abs.tol = abs.tol)
  emp.q <- sort(data)

  ## plot ghyp quantiles
  plot(ghyp.q, emp.q, xlab = xlab, ylab = ylab, pch = ghyp.pch, 
       col = ghyp.col, main = main, ...)

  if(gaussian == TRUE){
    gauss.q <- qnorm(ghyp.p, mean = mean(data), sd = sd(data))
    points(gauss.q, emp.q, pch = gauss.pch, col = gauss.col)
  }

  if(line == TRUE){
    abline(lm(emp.q ~ ghyp.q), lty = ghyp.lty, col = ghyp.col)
    if(gaussian == TRUE){
      abline(lm(emp.q ~ gauss.q), lty = gauss.lty, col = gauss.col)
    }
  }

 if(plot.legend == TRUE){
  if(gaussian == TRUE){
    legend(location, legend = c(ghyp.name(object, abbr = TRUE, skew.attr = TRUE), "Gaussian"), col = c(ghyp.col, gauss.col),
           lty = c(ghyp.lty, gauss.lty), cex = legend.cex, pch = c(ghyp.pch,gauss.pch))
  }else{
    legend(location, legend = ghyp.name(object, abbr = TRUE, skew.attr = TRUE), col = ghyp.col,
           lty = ghyp.lty, cex = legend.cex, pch = ghyp.pch)
  }

 }
}
