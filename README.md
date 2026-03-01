# 🍔 DEATS CAFÉ — Full Stack Web App

**East Tambaram, Chennai | 39 Nehruji Street, Anandhapuram**

A complete full-stack website for Deats Café with a Node.js/Express REST API backend, liquid-glass frontend, and production-ready Docker deployment.

---

## 📁 Project Structure

```
deats-cafe/
├── backend/
│   ├── server.js        # Express app — all API routes
│   └── db.js            # In-memory data store (swap for MongoDB)
├── frontend/
│   └── public/
│       └── index.html   # Liquid glass UI (full single-page site)
├── tests/
│   └── api.test.js      # Jest + Supertest API tests
├── .env.example         # Environment variable template
├── Dockerfile           # Multi-stage Docker build
├── docker-compose.yml   # Full stack orchestration
├── nginx.conf           # Production Nginx reverse proxy
└── package.json
```

---

## 🚀 Quick Start (Local Development)

### 1. Install dependencies
```bash
npm install
```

### 2. Set up environment
```bash
cp .env.example .env
# Edit .env with your SMTP credentials
```

### 3. Run development server
```bash
npm run dev          # uses nodemon for auto-reload
# or
npm start            # plain node
```

App runs at → **http://localhost:5000**

---

## 🧪 Run Tests
```bash
npm test
```
Tests cover: health, menu, reservations, contact, reviews, orders, newsletter, admin stats.

---

## 🌐 API Endpoints

| Method | Endpoint                        | Description                    |
|--------|---------------------------------|--------------------------------|
| GET    | `/api/health`                   | Server health check            |
| GET    | `/api/info`                     | Café info (address, hours…)    |
| GET    | `/api/menu`                     | All menu items                 |
| GET    | `/api/menu?category=burger`     | Filter by category             |
| GET    | `/api/menu/featured`            | Featured items only            |
| GET    | `/api/menu/categories`          | Available categories           |
| POST   | `/api/reservations`             | Create a table reservation     |
| GET    | `/api/reservations?date=…`      | Get reservations by date       |
| PUT    | `/api/reservations/:id/status`  | Update reservation status      |
| POST   | `/api/contact`                  | Submit a contact/enquiry form  |
| GET    | `/api/reviews`                  | Get approved reviews           |
| POST   | `/api/reviews`                  | Submit a review (pending)      |
| POST   | `/api/orders`                   | Place a pre-order / pickup     |
| GET    | `/api/orders/:id`               | Get order by ID                |
| POST   | `/api/newsletter`               | Subscribe to newsletter        |
| GET    | `/api/admin/stats`              | Admin dashboard stats          |

### Example — Create Reservation
```bash
curl -X POST http://localhost:5000/api/reservations \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Ravi Kumar",
    "phone": "9876543210",
    "email": "ravi@email.com",
    "date": "2025-12-25",
    "time": "18:00",
    "guests": 4,
    "notes": "Window table preferred"
  }'
```

### Example — Place Order
```bash
curl -X POST http://localhost:5000/api/orders \
  -H "Content-Type: application/json" \
  -d '{
    "customerName": "Meera",
    "phone": "9988776655",
    "type": "pickup",
    "items": [
      { "id": "joge-burger", "quantity": 2 },
      { "id": "piri-piri-fries", "quantity": 1 },
      { "id": "oreo-frappe", "quantity": 2 }
    ]
  }'
```

---

## 🐳 Docker Deployment

### Build & run locally
```bash
docker-compose up --build
```

### Production build only
```bash
docker build -t deats-cafe .
docker run -p 5000:5000 --env-file .env deats-cafe
```

---

## ☁️ Deploy to a VPS (Hostinger / DigitalOcean / AWS EC2)

### Step 1 — Server setup (Ubuntu 22.04)
```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Install Node.js 22
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt install -y nodejs

# Install Docker + Docker Compose
sudo apt install -y docker.io docker-compose
sudo systemctl enable --now docker
```

### Step 2 — Clone & configure
```bash
git clone https://github.com/youruser/deats-cafe.git
cd deats-cafe
cp .env.example .env
nano .env    # Fill in your credentials
```

### Step 3 — Run with Docker Compose
```bash
sudo docker-compose up -d --build
```

### Step 4 — Set up Nginx + SSL (Let's Encrypt)
```bash
# Install Certbot
sudo apt install -y nginx certbot python3-certbot-nginx

# Get SSL certificate
sudo certbot --nginx -d deatscafe.in -d www.deatscafe.in

# Copy nginx config
sudo cp nginx.conf /etc/nginx/sites-available/deatscafe
sudo ln -s /etc/nginx/sites-available/deatscafe /etc/nginx/sites-enabled/
sudo nginx -t && sudo systemctl reload nginx
```

### Step 5 — Auto-restart on reboot
```bash
sudo systemctl enable docker
# Docker Compose with restart: unless-stopped handles auto-restart
```

---

## 🚀 Deploy to Render.com (Free / Easy)

1. Push code to GitHub
2. Go to [render.com](https://render.com) → New Web Service
3. Connect your GitHub repo
4. Settings:
   - **Build command:** `npm install`
   - **Start command:** `npm start`
   - **Environment:** Add all vars from `.env.example`
5. Click Deploy → Done! ✅

---

## 🚀 Deploy to Railway.app

```bash
# Install Railway CLI
npm install -g @railway/cli
railway login
railway init
railway up
```

---

## 🗄️ Upgrading to MongoDB (Production)

Replace `db.js` with Mongoose models:

```bash
npm install mongoose
```

Set `MONGO_URI` in `.env`, then swap each `db.*` call with:
```js
const Reservation = require('./models/Reservation');
await Reservation.create(data);   // instead of db.createReservation(data)
```

---

## 📧 Email Setup (Gmail)

1. Go to Google Account → Security → 2-Step Verification → App Passwords
2. Generate an App Password for "Mail"
3. Set in `.env`:
   ```
   SMTP_HOST=smtp.gmail.com
   SMTP_USER=your@gmail.com
   SMTP_PASS=xxxx-xxxx-xxxx-xxxx
   ```

---

## 📞 Café Contact
- **Phone:** +91 89250 90625
- **Address:** 39 Nehruji Street, Anandhapuram, East Tambaram, Chennai 600059
- **Hours:** 1:00 PM – 9:30 PM, 7 days a week
