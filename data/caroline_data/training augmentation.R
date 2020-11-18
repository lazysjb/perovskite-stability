
library(tidyverse)
library(janitor)

current_train <- readxl::read_xlsx("/Users/carolinerutherford/OneDrive - cumc.columbia.edu/Data Science Institute/Capstone/Perovskite Stability/Data Augmentation/Data_and_Code/Code/perovskite_DFT_EaH_FormE.xlsx") %>%
  clean_names()

jacobs_data <- read_csv("/Users/carolinerutherford/OneDrive - cumc.columbia.edu/Data Science Institute/Capstone/Perovskite Stability/Data Augmentation/all_jacobs.csv") %>%
  clean_names() %>%
  mutate(simulated_composition = str_remove(simulated_composition, "\n"),
         energy_above_convex_hull_me_v_atom = as.numeric(energy_above_convex_hull_me_v_atom),
         formation_energy_e_v_atom = as.numeric(formation_energy_e_v_atom))

all_data <- inner_join(jacobs_data, current_train, c("simulated_composition" = "material_composition"))
jacobs_data$repeats <- duplicated(jacobs_data$simulated_composition)

a_site <- unique(c(current_train$a_site_number_1, current_train$a_site_number_2, current_train$a_site_number_3))
b_site <- unique(c(current_train$b_site_number_1, current_train$b_site_number_2, current_train$b_site_number_3))
x_site <- unique(current_train$x_site)


not_included <- filter(all_data, is.na(formation_energy_e_v_atom.y)==T) %>%
  select(-ends_with(".y")) %>%
  select(c(simulated_composition, energy_above_convex_hull_me_v_atom, formation_energy_e_v_atom.x)) %>%
  mutate(simulated_composition2 = str_replace_all(simulated_composition, c("[0-9]"), ".")) %>%
  separate(simulated_composition2, c("e1", "e2", "e3", "e4", "e5", "e6"), fill = "right") %>%
  mutate_at(c("e1", "e2", "e3", "e4", "e5", "e6"), ~na_if(.,"")) %>%
  mutate(a_site_1 = ifelse(e1 %in% a_site, e1,
                           ifelse(e2 %in% a_site, e2,
                                  ifelse(e3 %in% a_site, e3,
                                         ifelse(e4 %in% a_site, e4,
                                                ifelse(e5 %in% a_site, e5,
                                                       ifelse(e6 %in% a_site, e6, NA)))))),
         a_site_2 = ifelse(e1 %in% a_site & e1 != a_site_1, e1,
                           ifelse(e2 %in% a_site & e2 != a_site_1, e2,
                                  ifelse(e3 %in% a_site & e3 != a_site_1, e3,
                                         ifelse(e4 %in% a_site & e4 != a_site_1, e4,
                                                ifelse(e5 %in% a_site & e5 != a_site_1, e5,
                                                       ifelse(e6 %in% a_site & e6 != a_site_1, e6, NA)))))),
         a_site_3 = ifelse(e1 %in% a_site & e1 != a_site_1 & e1 != a_site_2, e1,
                           ifelse(e2 %in% a_site & e2 != a_site_1 & e2 != a_site_2, e2,
                                  ifelse(e3 %in% a_site & e3 != a_site_1 & e3 != a_site_2, e3,
                                         ifelse(e4 %in% a_site & e4 != a_site_1 & e4 != a_site_2, e4,
                                                ifelse(e5 %in% a_site & e5 != a_site_1 & e5 != a_site_2, e5,
                                                       ifelse(e6 %in% a_site & e6 != a_site_1 & e6 != a_site_2, e6, NA))))))) %>%
  mutate(b_site_1 = ifelse(e1 %in% b_site, e1,
                           ifelse(e2 %in% b_site, e2,
                                  ifelse(e3 %in% b_site, e3,
                                         ifelse(e4 %in% b_site, e4,
                                                ifelse(e5 %in% b_site, e5,
                                                       ifelse(e6 %in% b_site, e6, NA)))))),
         b_site_2 = ifelse(e1 %in% b_site & e1 != b_site_1, e1,
                           ifelse(e2 %in% b_site & e2 != b_site_1, e2,
                                  ifelse(e3 %in% b_site & e3 != b_site_1, e3,
                                         ifelse(e4 %in% b_site & e4 != b_site_1, e4,
                                                ifelse(e5 %in% b_site & e5 != b_site_1, e5,
                                                       ifelse(e6 %in% b_site & e6 != b_site_1, e6, NA)))))),
         b_site_3 = ifelse(e1 %in% b_site & e1 != b_site_1 & e1 != b_site_2, e1,
                           ifelse(e2 %in% b_site & e2 != b_site_1 & e2 != b_site_2, e2,
                                  ifelse(e3 %in% b_site & e3 != b_site_1 & e3 != b_site_2, e3,
                                         ifelse(e4 %in% b_site & e4 != b_site_1 & e4 != b_site_2, e4,
                                                ifelse(e5 %in% b_site & e5 != b_site_1 & e5 != b_site_2, e5,
                                                       ifelse(e6 %in% b_site & e6 != b_site_1 & e6 != b_site_2, e6, NA))))))) %>%
  mutate(x_site = ifelse(e1 %in% x_site, e1,
                           ifelse(e2 %in% x_site, e2,
                                  ifelse(e3 %in% x_site, e3,
                                         ifelse(e4 %in% x_site, e4,
                                                ifelse(e5 %in% x_site, e5,
                                                       ifelse(e6 %in% x_site, e6, NA))))))) %>%
  group_by(simulated_composition) %>%
  mutate(number_of_elements = 6-sum(is.na(e1) + is.na(e2) + is.na(e3) + is.na(e4) + is.na(e5) + is.na(e6))) %>% 
  select(c(simulated_composition, a_site_1, a_site_2, a_site_3, b_site_1, b_site_2, b_site_3, x_site, number_of_elements, energy_above_convex_hull_me_v_atom, formation_energy_e_v_atom.x)) %>%
  write_csv("/Users/carolinerutherford/OneDrive - cumc.columbia.edu/Data Science Institute/Capstone/Perovskite Stability/Data Augmentation/not_included.csv", na = "")











