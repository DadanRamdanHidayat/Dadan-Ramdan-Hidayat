library(tidyverse)
library(lubridate)

# 1. Baca semua file CSV dari folder "data/"
file_list <- list.files("data", pattern = "*.csv", full.names = TRUE)

# 2. Gabungkan data
data_penjualan <- file_list %>%
  map_dfr(read_csv)

# 3. Ubah format tanggal
data_penjualan <- data_penjualan %>%
  mutate(tanggal_transaksi = as.Date(tanggal_transaksi))

# 4. Bersihkan data: hapus NA dan duplikat
data_penjualan <- data_penjualan %>%
  drop_na() %>%
  distinct()

# 5. Tambahkan kolom bulan (untuk analisis tren bulanan)
data_penjualan <- data_penjualan %>%
  mutate(bulan = month(tanggal_transaksi, label = TRUE, abbr = FALSE))

# Simpan data bersih (jika ingin)
# write_csv(data_penjualan, "data/data_penjualan_bersih.csv")

# Tampilkan ringkasan
glimpse(data_penjualan)
