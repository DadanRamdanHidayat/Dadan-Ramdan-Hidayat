---
title: "Laporan Analisis Penjualan E-Commerce"
output: html_document
---

```{r setup, include=FALSE}
library(tidyverse)
library(lubridate)
library(ggplot2)
````

## 📌 Tujuan Analisis

Menganalisis performa penjualan dari sebuah e-commerce selama 6 bulan terakhir berdasarkan data transaksi yang telah dibersihkan melalui proses data wrangling.

## 📥 Import & Gabungkan Data

```{r}
# Baca semua file dari folder data
file_list <- list.files("data", pattern = "*.csv", full.names = TRUE)
data_penjualan <- file_list %>%
  map_dfr(read_csv)

# Format tanggal dan bersihkan
data_penjualan <- data_penjualan %>%
  mutate(
    tanggal_transaksi = as.Date(tanggal_transaksi),
    bulan = month(tanggal_transaksi, label = TRUE, abbr = FALSE)
  ) %>%
  drop_na() %>%
  distinct()

glimpse(data_penjualan)
```

## 📊 Statistik Deskriptif

```{r}
# Total transaksi dan total penjualan
data_penjualan %>%
  summarise(
    total_transaksi = n(),
    total_penjualan = sum(total_penjualan)
  )
```

## 📈 Visualisasi Penjualan per Bulan

```{r}
data_penjualan %>%
  group_by(bulan) %>%
  summarise(total = sum(total_penjualan)) %>%
  ggplot(aes(x = bulan, y = total)) +
  geom_col(fill = "steelblue") +
  labs(title = "Total Penjualan per Bulan", x = "Bulan", y = "Total Penjualan (Rp)") +
  theme_minimal()
```

## 🛒 Produk Terlaris

```{r}
data_penjualan %>%
  group_by(produk) %>%
  summarise(total = sum(total_penjualan)) %>%
  arrange(desc(total)) %>%
  head(5)
```

## 🧠 Insight Awal

* Penjualan tertinggi terjadi di bulan tertentu (lihat grafik).
* Produk paling laris adalah produk dengan total penjualan terbesar.
* Kategori tertentu mungkin mendominasi kontribusi penjualan (bisa dianalisis lebih lanjut).

```
