# Complete R script to generate ops_analytics_dataset.csv

set.seed(42)  # For reproducibility
library(dplyr)
library(lubridate)
library(stringr)

n <- 5000  # Number of orders

# Define categories for categorical columns
ship_modes <- c('Ground', 'Air', 'Two-Day', 'Overnight')
warehouses <- c('WH_North', 'WH_South', 'WH_East', 'WH_West', 'WH_Central')
states <- c('TX','CA','NY','FL','IL','PA','OH','GA','NC','MI')
product_categories <- c('Electronics','Home','Apparel','Beauty','Sports','Toys')
order_priorities <- c('Low','Medium','High','Critical')
promo_codes <- c(NA, 'SUMMER10', 'FREESHIP', 'WELCOME5')
customer_segments <- c('Consumer','SMB','Enterprise')
carriers <- c('CarrierA','CarrierB','CarrierC','CarrierD')

# Generate order-level data
orders <- tibble(
  order_id = str_c("O", str_pad(1:n, 6, pad = "0")),
  customer_id = str_c("C", sample(1000:2999, n, replace = TRUE)),
  order_date = as.Date("2024-01-01") + sample(0:700, n, replace = TRUE),
  ship_mode = sample(ship_modes, n, replace = TRUE, prob = c(0.6,0.1,0.2,0.1)),
  origin_warehouse = sample(warehouses, n, replace = TRUE),
  dest_state = sample(states, n, replace = TRUE),
  dest_city = str_c("City_", sample(1:400, n, replace = TRUE)),
  product_category = sample(product_categories, n, replace = TRUE),
  product_id = str_c("P", sample(1000:9999, n, replace = TRUE)),
  quantity = rpois(n, lambda = 2) + 1,
  unit_price = round(rnorm(n, mean = 50, sd = 20), 2),
  order_priority = sample(order_priorities, n, replace = TRUE, prob = c(0.5,0.35,0.12,0.03)),
  promo_code = sample(promo_codes, n, replace = TRUE),
  customer_segment = sample(customer_segments, n, replace = TRUE),
  carrier = sample(carriers, n, replace = TRUE)
)

# Calculate order_value, shipping_cost, delivery_time_days, delivery_date
orders <- orders %>%
  mutate(
    order_value = round(quantity * unit_price, 2),
    shipping_cost = case_when(
      ship_mode == 'Ground' ~ round(5 * runif(n, 1, 1.5), 2),
      ship_mode == 'Air' ~ round(25 * runif(n, 1, 1.5), 2),
      ship_mode == 'Two-Day' ~ round(12 * runif(n, 1, 1.5), 2),
      ship_mode == 'Overnight' ~ round(40 * runif(n, 1, 1.5), 2)
    ),
    base_days = case_when(
      ship_mode == 'Ground' ~ 5,
      ship_mode == 'Air' ~ 2,
      ship_mode == 'Two-Day' ~ 2,
      ship_mode == 'Overnight' ~ 1
    ),
    delay_days = pmax(0, round(rnorm(n, mean = 0.8, sd = 2))),
    # Occasionally add big delays
    delay_days = ifelse(runif(n) < 0.03, delay_days + sample(3:10, n, replace = TRUE), delay_days),
    delivery_time_days = base_days + delay_days,
    ship_date = order_date + sample(0:2, n, replace = TRUE),
    delivery_date = ship_date + delivery_time_days,
    delivery_status = ifelse(runif(n) < 0.02, 'Lost', 'Delivered'),
    returned = ifelse(runif(n) < 0.04, 'Yes', 'No'),
    cost_of_goods = round(order_value * ifelse(product_category=='Electronics', 0.5, runif(n, 0.35, 0.55)),2),
    labor_time_minutes = quantity * (10 + rpois(n, 5)),
    profit = round(order_value - cost_of_goods - shipping_cost - (labor_time_minutes*0.12),2),
    profit_margin = round(ifelse(order_value>0, profit/order_value, 0), 3)
  ) %>%
  select(
    order_id, customer_id, order_date, ship_date, delivery_date,
    ship_mode, origin_warehouse, dest_city, dest_state,
    product_category, product_id, quantity, unit_price, order_value,
    shipping_cost, delivery_time_days, delivery_status, returned,
    cost_of_goods, labor_time_minutes, order_priority, promo_code,
    customer_segment, carrier, profit, profit_margin
  )

# Save to CSV
write.csv(orders, "ops_analytics_dataset.csv", row.names = FALSE)
df <- df %>%
  clean_names() %>%
  mutate(
    order_date = ymd(order_date),
    ship_date = ymd(ship_date),
    delivery_date = ymd(delivery_date),
    order_value = as.numeric(order_value),
    shipping_cost = as.numeric(shipping_cost),
    delivery_time_days = as.integer(delivery_time_days),
    cost_of_goods = as.numeric(cost_of_goods),
    labor_time_minutes = as.numeric(labor_time_minutes),
    profit = as.numeric(profit),
    profit_margin = as.numeric(profit_margin),
    returned = if_else(is.na(returned), "No", returned),
    promo_code = if_else(is.na(promo_code), "None", promo_code)
  )
df <- read_csv("ops_analytics_dataset.csv", show_col_types = FALSE)
glimpse(df)
summary(select(df, order_value, shipping_cost, delivery_time_days, profit, labor_time_minutes))

df <- df %>%
  +     mutate(
    +         order_week = isoweek(order_date),
    +         order_month = month(order_date, label = TRUE, abbr = TRUE),
    +         order_year = year(order_date),
    +         fulfillment_lag_days = as.integer(difftime(ship_date, order_date, units="days")),
    +         delivery_lag = delivery_time_days - fulfillment_lag_days,
    +         on_time = if_else(delivery_time_days <= case_when(
      +             ship_mode == 'Ground' ~ 7,
      +             ship_mode == 'Air' ~ 3,
      +             ship_mode == 'Two-Day' ~ 3,
      +             ship_mode == 'Overnight' ~ 2,
      +             TRUE ~ 7), 1, 0)
    )
# Warehouse performance
warehouse_perf <- df %>%
  group_by(origin_warehouse) %>%
  summarise(
    orders = n(),
    avg_delivery = mean(delivery_time_days, na.rm=TRUE),
    on_time_rate = mean(on_time, na.rm=TRUE)
  ) %>%
  arrange(avg_delivery)


carrier_perf <- df %>%
  group_by(carrier) %>%
  summarise(
    orders = n(),
    avg_delivery = mean(delivery_time_days),
    on_time_rate = mean(on_time)
  ) %>%
  arrange(avg_delivery)
cat_profit <- df %>%
  group_by(product_category) %>%
  summarise(
    orders = n(),
    avg_order_value = mean(order_value),
    avg_profit = mean(profit),
    avg_margin = mean(profit_margin)
  ) %>%
  arrange(desc(avg_profit))
# Return & lost rates
status_rates <- df %>%
  summarise(
    lost_rate = mean(delivery_status != "Delivered"),
    return_rate = mean(returned == "Yes")
  )

