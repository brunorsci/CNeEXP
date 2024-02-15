#generate vector of 100 values that follows a normal distribution
normal <- rnorm(100000)

#create Q-Q plot
qqnorm(normal, main = 'Distribuição Normal', xlab = 'Distribuição teorica (normal)',
       ylab = 'Distribuição normal(exemplo)', col = 'steelblue')
qqline(normal)


# Segmentation Distribution
data <- all_cnvs_exp$segment_mean

#create Q-Q plot
qqnorm(data, main = 'Segmentação de CNVs', xlab = 'Distribuição teorica (normal)',
       ylab = 'Distribuição Amostra', col = 'steelblue')

qqline(data)

# Expression RNASeq Distribution
dataEXP <- all_cnvs_exp$normalized_read_count

#create Q-Q plot
qqnorm(dataEXP, main = 'RNASeq normalizado', xlab = 'Distribuição teorica (normal)',
       ylab = 'Distribuição Amostra', col = 'steelblue')

qqline(dataEXP)
