#!/bin/bash

set -e
set -o pipefail

# Plot gender distribution
Rscript --vanilla gender-distribution.R
