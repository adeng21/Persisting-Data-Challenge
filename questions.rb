# What 3 towns have the highest population of citizens that are 65 years and older?

TownHealthRecord.select("town").order(population_greater_than_65_2005: :desc).limit(3).offset(3)

# What 3 towns have the highest population of citizens that are 19 years and younger?

TownHealthRecord.select("town").order(population_0_to_19_2005: :desc).limit(3).offset(3)

# What 5 towns have the lowest per capita income?

TownHealthRecord.select("town").order(per_capita_income_2000: :asc).limit(5)

# Omitting Boston, Becket, and Beverly, what town has the highest percentage of teen births?

TownHealthRecord.select("town").where.not(percent_teen_births_2005_to_2008: nil).where.not(town: ["Boston", "Becket", "Beverly"]).order(percent_teen_births_2005_to_2008: :desc).limit(1)

# Omitting Boston, what town has the highest number of infant mortalities?

TownHealthRecord.select("town").where.not(infant_mortality_rate_per_thousand_2005_to_2008: nil).where.not(town: "Boston").order(infant_mortality_rate_per_thousand_2005_to_2008: :desc).limit(1)

# Of the 5 towns with the highest per capita income, which one has the highest number of people below the poverty line?

TownHealthRecord.select("town").where(town: TownHealthRecord.select("town").order(per_capita_income_2000: :desc).limit(5).offset(2)).order("(percent_persons_below_poverty_2000*total_population_2005) DESC").limit(1)

# Of the towns that start with the letter b, which has the highest population?

TownHealthRecord.select("town").where("town like ?", "B%").order(total_population_2005: :desc).limit(1)

# Of the 10 towns with the highest percent publicly financed prenatal care, are any of them also the top 10 for total infant deaths?

TownHealthRecord.select("town").where(town: TownHealthRecord.select("town").where.not(percent_publicly_financed_prenatal_care_2005_to_2008: nil).order(percent_publicly_financed_prenatal_care_2005_to_2008: :desc).limit(10)).where(town: TownHealthRecord.select("town").where.not(total_infant_deaths_2005_to_2008: nil).order(total_infant_deaths_2005_to_2008: :desc).limit(10).offset(1))

# Which town has the highest percent multiple births?

TownHealthRecord.select("town").where.not(percent_multiple_births_2005_to_2008: nil).order(percent_multiple_births_2005_to_2008: :desc).limit(1)

# What is the percent adequacy of prenatal care in that town?

TownHealthRecord.select("percent_adequacy_pre_natal_care").where(town: TownHealthRecord.select("town").where.not(percent_multiple_births_2005_to_2008: nil).order(percent_multiple_births_2005_to_2008: :desc).limit(1))

# Excluding towns that start with W, how many towns are part of this data?

TownHealthRecord.select("town").where.not("town like ?", "W%").count

# How many towns have a lower per capita income that of Boston?

TownHealthRecord.select("town").where("per_capita_income_2000 < ?", TownHealthRecord.where("town = ?", "Boston").pluck('per_capita_income_2000')).count
