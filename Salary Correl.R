library("dplyr")
library("echarts4r")

df <- as_tibble(
  read.csv(
    'C://Users//marco//OneDrive//Documentos//Projetos//R//Projetos Estudo//04 - Correlação com dataset de salários//Salary Data.csv'
  )
)

df

df <- df %>% dplyr::rename(
  Experience = Years.of.Experience
  )

#Análise do DF
unique(df$Experience)
unique(df$Salary)
unique(df$Age)
unique(df$Education.Level)

na_count <- sum(is.na(df))
print(na_count)

df_numeric <- df %>% select("Age", "Experience", "Salary")

df_numeric

df_numeric <- na.omit(df_numeric)

cor_matrix <- cor(df_numeric, method = "spearman")

cor_matrix[upper.tri(cor_matrix)] <- NA

# Converter a matriz de correlação em um dataframe adequado para heatmap
cor_data <- as.data.frame(as.table(cor_matrix))

# Criar o gráfico de correlação
correl_chart <- cor_data |>
  e_charts(Var1) |> 
  e_heatmap(Var2, Freq) |> 
  e_visual_map(
    min = -1,
    max = 1
  ) |> 
  e_tooltip()

correl_chart
