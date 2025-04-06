# Sehattek Deployment Guide

Saya belum berhasil membuat `docker-compose` tunggal yang menggabungkan Flutter Web App dengan Supabase custom schema. Oleh karena itu, deployment dilakukan dengan **self-hosted Supabase menggunakan Docker Full Service**, serta menambahkan container untuk aplikasi Flutter.

---

## 1. Pull Supabase dengan Docker

```bash
# Get the code
git clone --depth 1 https://github.com/supabase/supabase

# Go to the docker folder
cd supabase/docker

# Copy the fake env vars
cp .env.example .env

# Pull the latest images
docker compose pull

# Start the services (in detached mode)
docker compose up -d
```

---

## 2. Edit `docker-compose.yml`

Tambahkan konfigurasi berikut di bagian `services`:

```yaml
sehattek_web:
  image: izaa/sehattek-app:latest
  container_name: sehattek-web-app
  ports:
    - "8080:80"
  networks:
    - default
  depends_on:
    - db

nginx:
  image: "jc21/nginx-proxy-manager:latest"
  restart: unless-stopped
  ports:
    - "80:80"
    - "443:443"
    - "81:81"
  volumes:
    - ./nginx-data:/data
    - ./nginx-letsencrypt:/etc/letsencrypt
    - ./nginx-snippets:/snippets:ro
  environment:
    TZ: "Europe/Berlin"
```

---

## 3. Build dan Jalankan Docker

Untuk membangun ulang dan menjalankan semua service:

```bash
docker compose up --build -d
```

Jika tidak perlu membangun ulang:

```bash
docker compose up -d
```

---

## 4. Routing via Nginx Proxy Manager

1. Akses **Nginx Proxy Manager**:
   ```
   http://localhost:81
   ```
2. Login dengan default akun:
   - **Email**: `admin@example.com`
   - **Password**: `changeme`
3. Buka menu **Proxy Hosts** dan klik **Add Proxy Host**
4. Isi form:
   - **Domain Names**: (gunakan domain Anda atau IP lokal)
   - **Forward Hostname / IP**: `sehattek-web-app`
   - **Forward Port**: `80`
   - Centang **Block Common Exploits**
   - Klik **Save**

---

## 5. Jalankan `init.sql` di Supabase Studio

Untuk membuat schema, tabel, trigger, dan konfigurasi lainnya:

1. Akses Supabase Studio:
   ```
   http://localhost:3000
   ```
2. Login dengan kredensial admin Supabase
3. Masuk ke **SQL Editor**
4. Copy isi file `init.sql` Anda ke editor tersebut
5. Klik **Run**

Ini akan menginisialisasi semua struktur database (tabel, trigger, dsb.) yang dibutuhkan oleh aplikasi Flutter.
