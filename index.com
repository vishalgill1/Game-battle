<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>GameX - Play. Win. Repeat.</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
  <style>
    body {
      margin: 0;
      font-family: 'Segoe UI', Arial, sans-serif;
      background: #18102e;
      color: #fff;
      min-height: 100vh;
    }

    a {
      color: inherit;
      text-decoration: none;
    }

    .navbar {
      display: flex;
      align-items: center;
      justify-content: space-between;
      background: #160e27;
      padding: 16px 14px 10px 14px;
      border-bottom: 1px solid #2c2042;
      position: sticky;
      top: 0;
      z-index: 20;
    }

    .logo {
      display: flex;
      align-items: center;
    }
    .logo img {
      height: 30px;
      width: 30px;
      border-radius: 8px;
      background: #33245b;
      margin-right: 8px;
      object-fit: contain;
    }
    .logo span {
      font-weight: 600;
      font-size: 19px;
      letter-spacing: 1px;
    }

    .nav-icons {
      display: flex;
      align-items: center;
    }
    .nav-icons a {
      margin: 0 7px;
      font-size: 19px;
      color: #fff;
      background: #2d2243;
      border-radius: 6px;
      width: 34px;
      height: 34px;
      display: flex;
      align-items: center;
      justify-content: center;
      transition: background 0.2s;
    }
    .nav-icons a:hover {
      background: #43306c;
    }
    .nav-icons .navbar-menu-btn {
      cursor: pointer;
      background: #ffad3b !important;
      color: #18102e !important;
    }
    .download-btn {
      padding: 7px 20px;
      background: linear-gradient(90deg, #ffad3b, #ff6f36);
      border-radius: 7px;
      color: #fff;
      font-weight: 600;
      margin-left: 10px;
      font-size: 16px;
      transition: opacity 0.2s;
      box-shadow: 0 2px 10px #ffad3b30;
    }
    .download-btn:hover {
      opacity: 0.85;
    }

    /* Sidebar styles */
    .sidebar {
      position: fixed;
      top: 0;
      right: -270px;
      width: 250px;
      height: 100vh;
      background: #22183f;
      box-shadow: -4px 0 30px #0003;
      z-index: 99;
      transition: right 0.29s cubic-bezier(0.73,0.13,0.38,0.89);
      display: flex;
      flex-direction: column;
      padding: 30px 20px 0 20px;
    }
    .sidebar.open {
      right: 0;
    }
    .sidebar .close-btn {
      align-self: flex-end;
      font-size: 1.8em;
      margin-bottom: 22px;
      cursor: pointer;
      color: #ffb945;
      background: none;
      border: none;
      outline: none;
      transition: color 0.18s;
    }
    .sidebar .close-btn:hover {
      color: #ff6f36;
    }
    .sidebar .side-menu {
      display: flex;
      flex-direction: column;
      gap: 20px;
    }
    .sidebar .side-menu a {
      padding: 15px 0 15px 12px;
      font-size: 1.11em;
      color: #fff;
      background: #140c22;
      border-radius: 8px;
      margin-bottom: 5px;
      font-weight: 500;
      transition: background 0.16s, color 0.16s;
      display: flex;
      align-items: center;
      gap: 9px;
    }
    .sidebar .side-menu a:hover {
      background: #ffad3b;
      color: #18102e;
    }
    .sidebar .side-download-btn {
      background: linear-gradient(90deg, #ffad3b 30%, #ff6f36 100%);
      color: #18102e;
      font-weight: bold;
      margin-top: 18px;
      justify-content: center;
      text-align: center;
    }

    /* Overlay */
    .sidebar-overlay {
      position: fixed;
      z-index: 90;
      inset: 0;
      background: rgba(0,0,0,0.32);
      display: none;
    }
    .sidebar.open ~ .sidebar-overlay {
      display: block;
    }

    .main-content {
      padding: 20px 12px 70px 12px;
      max-width: 440px;
      margin: auto;
    }

    .badge {
      display: inline-block;
      padding: 2px 16px;
      background: #2f1e07;
      color: #ffad3b;
      font-size: 13px;
      border-radius: 14px;
      font-weight: 600;
      margin-bottom: 16px;
      letter-spacing: 0.8px;
    }

    h1 {
      margin-top: 0;
      font-size: 2.1em;
      font-weight: bold;
      background: linear-gradient(90deg, #ffed91 20%, #ffad3b 100%);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      background-clip: text;
      text-fill-color: transparent;
    }

    .main-content p {
      color: #b3b4d6;
      margin-bottom: 20px;
      font-size: 1em;
      line-height: 1.5;
    }

    .orange-btn {
      display: block;
      width: 100%;
      border: none;
      margin-bottom: 12px;
      font-size: 18px;
      font-weight: 600;
      padding: 13px 0;
      background: linear-gradient(90deg, #ffad3b 30%, #ff6f36 100%);
      color: #fff;
      border-radius: 10px;
      box-shadow: 0 2px 16px #ffad3b22;
      cursor: pointer;
      text-align: center;
    }

    .how-to-play-btn {
      display: block;
      background: #241542;
      color: #fff;
      font-weight: 500;
      padding: 13px 0;
      border-radius: 10px;
      border: none;
      width: 100%;
      text-align: center;
      font-size: 18px;
      margin-bottom: 32px;
      box-shadow: 0 2px 10px #0001;
      cursor: pointer;
    }

    .app-mockup {
      display: flex;
      justify-content: center;
      align-items: center;
      margin-bottom: 24px;
      margin-top: 18px;
    }
    .app-mockup img {
      width: 74%;
      border-radius: 18px;
      background: #251956;
      box-shadow: 0 4px 48px #0004;
      border: 3px solid #2d1840;
    }

    .withdrawals-section, .modes-section, .how-section, .facts-section {
      background: #231544;
      border-radius: 18px;
      padding: 20px 18px;
      margin-bottom: 22px;
      box-shadow: 0 2px 16px #121d382a;
    }

    .withdrawals-section h2, .modes-section h2, .how-section h2 {
      font-size: 1.2em;
      font-weight: 600;
      margin: 0 0 10px 0;
      color: #fff;
    }

    .recent-list {
      list-style: none;
      padding: 0;
      margin: 0;
      font-size: 1.07em;
    }
    .recent-list li {
      display: flex;
      justify-content: space-between;
      padding: 7px 0;
      border-bottom: 1px solid #392b57;
      color: #ffc25e;
      font-weight: 500;
    }
    .recent-list li:last-child { border-bottom: none; }

    .modes-items {
      display: flex;
      flex-direction: column;
      gap: 13px;
    }
    .mode-card {
      background: #20133a;
      border-radius: 12px;
      padding: 10px 16px;
      color: #fff;
      font-size: 1em;
    }
    .mode-card .title {
      color: #ffb945;
      font-weight: 600;
      margin-bottom: 2px;
      font-size: 1.04em;
    }
    .mode-card .desc {
      color: #b3b4d6;
      font-size: 0.98em;
    }

    .how-list {
      margin: 0;
      padding: 0;
      list-style: none;
      color: #fff;
      font-size: 1.05em;
    }
    .how-list li {
      margin-bottom: 12px;
    }
    .how-list span {
      background: #251d34;
      color: #ffb945;
      padding: 0 5px;
      font-weight: bold;
      border-radius: 5px;
      margin-right: 6px;
      font-size: 1.04em;
    }

    .custom-image-section {
      display: flex;
      justify-content: center;
      margin: 18px 0;
    }
    .custom-image-section img {
      max-width: 100%;
      border-radius: 16px;
      box-shadow: 0 2px 20px #0004;
    }

    .facts-section {
      text-align: center;
    }
    .facts-section .number {
      font-size: 1.27em;
      font-weight: 700;
      color: #ffeea2;
      margin: 5px 0;
    }
    .facts-section .label {
      font-size: 1em;
      color: #beb8cf;
      margin-bottom: 5px;
    }

    footer {
      text-align: center;
      color: #b3b4d6;
      background: none;
      margin-top: 22px;
      margin-bottom: 15px;
      font-size: 0.97em;
      padding-bottom: 12px;
    }

    /* Responsive tweaks */
    @media (max-width: 480px) {
      .navbar { flex-direction: column; align-items: stretch; gap: 12px; }
      .main-content { padding: 12px 5px 65px 5px; }
      .app-mockup img { width: 96%; }
      .withdrawals-section, .modes-section, .how-section, .facts-section {
        padding: 15px 4px;
        border-radius: 12px;
      }
      .sidebar { width: 78vw; min-width: 160px; }
    }
  </style>
</head>
<body>
  <nav class="navbar">
    <div class="logo">
      <img src="https://gamexofficial.site/assets/logo-icon.png" alt="GameX logo" onerror="this.style.display='none'">
      <span>GameX</span>
    </div>
    <div class="nav-icons">
      <a href="#"><i class="fab fa-whatsapp"></i></a>
      <a href="#"><i class="fab fa-telegram"></i></a>
      <a href="#"><i class="fab fa-youtube"></i></a>
      <span class="navbar-menu-btn" id="openSidebar" tabindex="0"><i class="fas fa-bars"></i></span>
    </div>
    <a class="download-btn" href="#">Download</a>
  </nav>

  <!-- Sidebar navigation menu -->
  <div id="sidebar" class="sidebar" aria-hidden="true">
    <button class="close-btn" id="closeSidebar" aria-label="Close menu"><i class="fas fa-times"></i></button>
    <nav class="side-menu">
      <a href="#" onclick="closeSidebar()" aria-label="Home">
        <i class="fas fa-home"></i> Home
      </a>
      <a href="https://api.whatsapp.com/send?phone=+919518692138&text=Hi" target="_blank" aria-label="Contact us on WhatsApp">
        <i class="fab fa-whatsapp"></i> Contact Us
      </a>
      <a class="side-download-btn" href="#">
        <i class="fas fa-download"></i> Download
      </a>
    </nav>
  </div>
  <div class="sidebar-overlay" id="sidebarOverlay"></div>

  <main class="main-content">
    <div class="badge">DAILY TOURNAMENTS</div>
    <h1>Play. Win. Repeat.</h1>
    <p>Join GameX Free Fire tournaments — Low entry, Fast payouts, 100% fair play.</p>
    <a class="orange-btn" href="#">&#8595; Download App</a>
    <a class="how-to-play-btn" href="#">How to Play</a>

    <div class="app-mockup">
      <img src="https://gamexofficial.site/assets/app-mockup.png" alt="GameX App Screenshot" onerror="this.style.display='none'">
    </div>

    <div class="withdrawals-section">
      <h2>Recent Withdrawals</h2>
      <ul class="recent-list">
        <li><span>anugaming</span> <span>&#8377;200</span></li>
        <li><span>anugaming</span> <span>&#8377;150</span></li>
        <li><span>Vikas</span> <span>&#8377;200</span></li>
        <li><span>ppgamer</span> <span>&#8377;200</span></li>
        <li><span>anugaming</span> <span>&#8377;200</span></li>
      </ul>
    </div>

    <div class="modes-section">
      <h2>Tournament Modes</h2>
      <div class="modes-items">
        <div class="mode-card">
          <div class="title">Per-Kill BR</div>
          <div class="desc">Earn per kill. Fast-paced matches.</div>
        </div>
        <div class="mode-card">
          <div class="title">BR Survival</div>
          <div class="desc">Top 3 share prize pool. Play smart, last long.</div>
        </div>
        <div class="mode-card">
          <div class="title">1v1 Duels</div>
          <div class="desc">Quick matches with instant winners.</div>
        </div>
      </div>
    </div>

    <div class="how-section">
      <h2>How it Works</h2>
      <ul class="how-list">
        <li><span>1 — Register</span> Create account with mobile number.</li>
        <li><span>2 — Join Match</span> Select tournament &amp; pay entry fee.</li>
        <li><span>3 — Win &amp; Withdraw</span> Get instant rewards in wallet.</li>
      </ul>
    </div>

    <div class="custom-image-section">
      <img src="https://images.png.com/photo-1511512578047-dfb367046420?auto=format&fit=crop&w=400&q=80"
        alt="How to Play Illustration">
    </div>

    <div class="facts-section">
      <div class="number">100,000+</div>
      <div class="label">Total Users</div>
      <div class="number">5,390,137</div>
      <div class="label">Total Matches Played</div>
      <div class="number">&#8377;7,886,510</div>
      <div class="label">Total Winnings</div>
    </div>
  </main>

  <footer>
    &copy; 2025 GameX — All rights reserved.
  </footer>

  <script>
    const openSidebarBtn = document.getElementById('openSidebar');
    const closeSidebarBtn = document.getElementById('closeSidebar');
    const sidebar = document.getElementById('sidebar');
    const sidebarOverlay = document.getElementById('sidebarOverlay');

    function openSidebar() {
      sidebar.classList.add('open');
      sidebar.setAttribute('aria-hidden', 'false');
      sidebarOverlay.style.display = 'block';
      document.body.style.overflow = 'hidden';
      // Set focus inside sidebar for accessibility
      closeSidebarBtn.focus();
    }
    function closeSidebar() {
      sidebar.classList.remove('open');
      sidebar.setAttribute('aria-hidden', 'true');
      sidebarOverlay.style.display = 'none';
      document.body.style.overflow = '';
      openSidebarBtn.focus();
    }

    openSidebarBtn.addEventListener('click', openSidebar);
    openSidebarBtn.addEventListener('keypress', function(e){
      if(e.key === 'Enter' || e.key === ' '){
        openSidebar();
        e.preventDefault();
      }
    });
    closeSidebarBtn.addEventListener('click', closeSidebar);
    sidebarOverlay.addEventListener('click', closeSidebar);

    // Optionally: Close on escape key
    window.addEventListener('keydown', function (e) {
      if (sidebar.classList.contains('open') && e.key === 'Escape') {
        closeSidebar();
      }
    });
  </script>
</body>
</html>
