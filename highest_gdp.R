library(data.table)
library(ggplot2)

# set wd, load data
setwd('/home/vcolano/Documents/worldDev/data')
indicators = fread('Indicators.csv')
attach(indicators)

econ_codes = c("USA", "CHN", "JPN", "DEU", "GBR")
econ_names = c("USA" = "United States","CHN" = "China", "JPN" = "Japan", 
               "DEU" = "Germany", "GBR" = "United Kingdom")
econs = subset(indicators, CountryCode %in% econ_codes)

# total life expectancy
life = subset(subset(econs, Year == "2013"), IndicatorCode == "SP.DYN.LE00.IN")


ggplot(data = life, aes(CountryCode, Value)) +
  geom_bar(aes(fill=CountryCode), stat="identity") +
  scale_x_discrete(limits = econ_codes, labels = econ_names) +
  scale_y_continuous(breaks = seq(0, 120, 10)) +
  theme_bw(base_size = 12, base_family = "Helvetica")+
  theme_classic() +
  theme(axis.ticks=element_blank(), legend.position="none") +
  ggtitle("Life expectancy at birth in total(years)") +
  ylab("Total life expectancy")

# Exports of goods and services
exports = subset(subset(econs, Year == "2013"), IndicatorCode == "BX.GSR.GNFS.CD")

ggplot(data = exports, aes(CountryCode, (Value/1000000000))) +
  geom_bar(aes(fill=CountryCode), stat="identity") +
  scale_x_discrete(limits = econ_codes, labels = econ_names) +
  scale_y_continuous(breaks = seq(0, 20000, 2500)) +
  theme_bw(base_size = 12, base_family = "Helvetica")+
  theme_classic() +
  theme(axis.ticks=element_blank(), legend.position="none") +
  ggtitle("Exports of goods and services in 2013 in USD") +
  ylab("Billions of USD")

# Smoking prevelance
smoke_m = subset(subset(econs, Year == "2012"), IndicatorCode == "SH.PRV.SMOK.MA")
smoke_f = subset(subset(econs, Year == "2012"), IndicatorCode == "SH.PRV.SMOK.FE")
smoke_m$Sex = rep("Male", length(smoke_m))
smoke_f$Sex = rep("Female", length(smoke_f))
smoke = rbind(smoke_m, smoke_f)

ggplot(data = smoke, aes(CountryCode, Value)) +
  geom_bar(aes(fill=Sex), stat="identity", position=position_dodge()) +
  scale_x_discrete(limits = econ_codes, labels = econ_names) +
  scale_y_continuous(breaks = seq(0, 80, 5), limits = c(0, 54)) +
  theme_bw(base_size = 12, base_family = "Helvetica")+
  theme_classic() +
  theme(axis.ticks=element_blank()) +
  ggtitle("Smoking prevalence in the world's 5 biggest economies in 2012") +
  ylab("Percent of Adults") +
  xlab("")
ggsave(file="smoking.png")
  

