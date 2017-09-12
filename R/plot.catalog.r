# ===============================================================================
#
# PROGRAMMERS:
#
# jean-romain.roussel.1@ulaval.ca  -  https://github.com/Jean-Romain/lidR
#
# COPYRIGHT:
#
# Copyright 2017 Jean-Romain Roussel
#
# This file is part of lidR R package.
#
# lidR is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>
#
# ===============================================================================



#' Plot a LAScatalog object
#'
#' This functions implements a \link[graphics:plot]{plot} method for LAScatalog objects
#'
#' @param x A LAScatalog object
#' @param y logical. Disable interactive display
#' @param \dots inherited from base plot
#' @method plot LAScatalog
#' @export
#' @examples
#' \dontrun{
#' ctg = catalog("<Path to a folder containing a set of .las files>")
#' plot(catalog)
#'
#' # Exemple with a single file
#' proj4   <- "+proj=utm +zone=17"
#' LASfile <- system.file("extdata", "Megaplot.laz", package="lidR")
#'
#' ctg = catalog(LASfile)
#' plot(ctg, proj4)
#' }
plot.LAScatalog = function(x, y = TRUE, ...)
{
  param = list(...)

  xmin = min(x@data$`Min X`)
  xmax = max(x@data$`Max X`)
  ymin = min(x@data$`Min Y`)
  ymax = max(x@data$`Max Y`)

  xcenter = (xmin + xmax)/2
  ycenter = (ymin + ymax)/2

  if (is.null(param$xlim))
    param$xlim = c(xmin, xmax)

  if (is.null(param$ylim))
    param$ylim = c(ymin, ymax)

  if (is.null(param$xlab))
    param$xlab = "X"

  if (is.null(param$ylab))
    param$ylab = "Y"

  if (is.null(param$asp))
    param$xlab = "X"

  if (is.null(param$asp))
    param$asp = 1

  if (is.null(param$col))
    param$col = "white"

  param$x = xcenter
  param$y = ycenter



  if (!is.na(x@crs@projargs) & y)
  {
    mapview::mapview(as.spatial(x))
  }
  else
  {
    do.call(graphics::plot, param)
    graphics::rect(x@data$`Min X`, x@data$`Min Y`, x@data$`Max X`, x@data$`Max Y`, col = grDevices::rgb(0, 0, 1, alpha=0.1))
  }
}

