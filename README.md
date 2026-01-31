<html lang="tr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>EBO Medikal - Servis Formu</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/qrcodejs/1.0.0/qrcode.min.js"></script>
<script src="https://www.gstatic.com/firebasejs/9.22.0/firebase-app-compat.js"></script>
<script src="https://www.gstatic.com/firebasejs/9.22.0/firebase-database-compat.js"></script>
<style>
* {
margin: 0;
padding: 0;
box-sizing: border-box;
-webkit-tap-highlight-color: transparent;
}

body {
font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
background: #f5f7fa;
min-height: 100vh;
padding: 10px;
}

.container {
max-width: 1000px;
margin: 0 auto;
background: white;
border-radius: 16px;
box-shadow: 0 4px 20px rgba(0,0,0,0.08);
overflow: hidden;
}

.header {
background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
padding: 20px;
text-align: center;
position: sticky;
top: 0;
z-index: 100;
}

.status-indicator {
position: absolute;
top: 15px;
right: 15px;
width: 12px;
height: 12px;
border-radius: 50%;
background: #dc3545;
border: 2px solid white;
}

.status-indicator.online {
background: #28a745;
box-shadow: 0 0 10px #28a745;
}

.header h1 {
color: #ffd700;
font-size: 1.3em;
font-weight: 700;
}

/* Tab Menü */
.tab-menu {
display: flex;
background: #f8f9fa;
border-bottom: 2px solid #e1e4e8;
}

.tab-btn {
flex: 1;
padding: 15px;
border: none;
background: none;
font-weight: 600;
color: #666;
cursor: pointer;
transition: all 0.3s;
}

.tab-btn.active {
color: #1a1a2e;
border-bottom: 3px solid #ffd700;
background: white;
}

/* Arama Bölümü */
.search-section {
padding: 20px;
background: #f8f9fa;
}

.search-box {
display: flex;
gap: 10px;
margin-bottom: 15px;
}

.search-input {
flex: 1;
padding: 12px 16px;
border: 2px solid #e1e4e8;
border-radius: 10px;
font-size: 16px;
}

.search-input:focus {
outline: none;
border-color: #ffd700;
}

.search-btn {
padding: 12px 24px;
background: #ffd700;
color: #1a1a2e;
border: none;
border-radius: 10px;
font-weight: 600;
cursor: pointer;
}

.filters {
display: flex;
gap: 10px;
flex-wrap: wrap;
}

.filter-select {
padding: 10px;
border: 1.5px solid #e1e4e8;
border-radius: 8px;
font-size: 14px;
background: white;
}

/* Aylık Rapor Bölümü */
.report-section {
padding: 20px;
display: none;
}

.report-section.active {
display: block;
}

.report-header {
display: flex;
justify-content: space-between;
align-items: center;
margin-bottom: 20px;
flex-wrap: wrap;
gap: 10px;
}

.report-title {
font-size: 1.2em;
color: #1a1a2e;
font-weight: 600;
}

.month-selector {
display: flex;
gap: 10px;
align-items: center;
}

.month-selector input {
padding: 10px;
border: 2px solid #e1e4e8;
border-radius: 8px;
font-size: 14px;
}

.summary-cards {
display: grid;
grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
gap: 15px;
margin-bottom: 25px;
}

.summary-card {
background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
color: white;
padding: 20px;
border-radius: 12px;
text-align: center;
}

.summary-card.revenue {
background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
}

.summary-card.pending {
background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
}

.summary-card.completed {
background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
}

.summary-card h3 {
font-size: 0.9em;
margin-bottom: 10px;
opacity: 0.9;
}

.summary-card .number {
font-size: 2em;
font-weight: 700;
}

.summary-card .label {
font-size: 0.8em;
opacity: 0.8;
margin-top: 5px;
}

.report-table {
width: 100%;
border-collapse: collapse;
background: white;
border-radius: 10px;
overflow: hidden;
box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.report-table th {
background: #1a1a2e;
color: #ffd700;
padding: 15px;
text-align: left;
font-weight: 600;
font-size: 0.85em;
}

.report-table td {
padding: 12px 15px;
border-bottom: 1px solid #e1e4e8;
font-size: 0.9em;
}

.report-table tr:hover {
background: #f8f9fa;
}

.report-table .tutar {
text-align: right;
font-weight: 600;
color: #28a745;
}

.report-table .durum-tamamlandi {
color: #28a745;
font-weight: 600;
}

.report-table .durum-beklemede {
color: #ffc107;
font-weight: 600;
}

.total-row {
background: #fff3cd !important;
font-weight: 700;
}

/* Liste Bölümü */
.list-section {
display: none;
}

.list-section.active {
display: block;
}

.results-info {
padding: 10px 20px;
background: #e9ecef;
font-size: 0.85em;
color: #495057;
font-weight: 500;
}

.forms-list {
max-height: 500px;
overflow-y: auto;
padding: 10px;
}

.form-item {
padding: 15px;
background: white;
border-radius: 10px;
margin-bottom: 10px;
border: 1.5px solid #e1e4e8;
cursor: pointer;
transition: all 0.2s;
}

.form-item:hover {
border-color: #ffd700;
transform: translateX(5px);
box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.form-item-header {
display: flex;
justify-content: space-between;
align-items: center;
margin-bottom: 8px;
}

.form-item-title {
font-weight: 600;
color: #1a1a2e;
font-size: 1em;
}

.form-item-id {
font-family: monospace;
font-size: 0.75em;
color: #666;
background: #f8f9fa;
padding: 2px 8px;
border-radius: 4px;
}

.form-item-details {
display: grid;
grid-template-columns: 1fr 1fr;
gap: 5px;
font-size: 0.85em;
color: #666;
margin-bottom: 8px;
}

.form-item-status {
display: inline-block;
padding: 4px 12px;
border-radius: 20px;
font-size: 0.75em;
font-weight: 600;
}

.status-beklemede { background: #fff3cd; color: #856404; }
.status-devam { background: #d1ecf1; color: #0c5460; }
.status-tamamlandi { background: #d4edda; color: #155724; }
.status-parca { background: #f8d7da; color: #721c24; }

.no-results {
text-align: center;
padding: 40px;
color: #999;
}

/* Form Düzenleme */
.form-section {
padding: 20px;
display: none;
}

.form-section.active {
display: block;
}

.section {
margin-bottom: 20px;
padding: 15px;
background: #fafbfc;
border-radius: 12px;
border-left: 4px solid #ffd700;
}

.section-title {
font-size: 0.95em;
color: #1a1a2e;
font-weight: 600;
margin-bottom: 12px;
}

.form-row {
display: flex;
flex-direction: column;
gap: 10px;
}

.form-group {
display: flex;
flex-direction: column;
}

label {
font-weight: 500;
color: #444;
margin-bottom: 5px;
font-size: 0.85em;
}

input, select, textarea {
padding: 12px;
border: 1.5px solid #e1e4e8;
border-radius: 10px;
font-size: 16px;
}

input:focus, select:focus, textarea:focus {
outline: none;
border-color: #ffd700;
}

textarea {
min-height: 80px;
resize: vertical;
}

.actions {
display: flex;
gap: 10px;
margin-top: 20px;
padding-top: 20px;
border-top: 2px solid #e1e4e8;
}

.btn {
flex: 1;
padding: 16px;
border-radius: 12px;
font-size: 1em;
font-weight: 600;
cursor: pointer;
border: none;
}

.btn-primary {
background: linear-gradient(135deg, #ffd700 0%, #ffed4e 100%);
color: #1a1a2e;
}

.btn-secondary {
background: #e9ecef;
color: #495057;
}

@media (min-width: 768px) {
body { padding: 20px; }
.form-row { display: grid; grid-template-columns: repeat(3, 1fr); }
.form-row.two-col { grid-template-columns: repeat(2, 1fr); }
.form-item-details { grid-template-columns: repeat(4, 1fr); }
.report-table { font-size: 0.95em; }
}

@media print {
.tab-menu, .search-section, .forms-list, .btn-secondary { display: none; }
.report-section { display: block !important; }
}
</style>
</head>
<body>
<div class="container">
<!-- Header -->
<div class="header">
<div class="status-indicator" id="statusIndicator"></div>
<h1>EBO MEDİKAL SERVİS FORMU</h1>
</div>

<!-- Tab Menü -->
<div class="tab-menu">
<button class="tab-btn active" onclick="showTab('list')">📋 Kayıtlar</button>
<button class="tab-btn" onclick="showTab('report')">📊 Aylık Rapor</button>
</div>

<!-- Liste Sekmesi -->
<div id="listTab" class="list-section active">
<div class="search-section">
<div class="search-box">
<input type="text" class="search-input" id="searchInput"
placeholder="Müşteri adı, telefon, cihaz veya ID ile ara..."
onkeyup="searchForms(event)">
<button class="search-btn" onclick="searchForms()">🔍 Ara</button>
</div>

<div class="filters">
<select class="filter-select" id="filterDurum" onchange="filterForms()">
<option value="">Tüm Durumlar</option>
<option>Beklemede</option>
<option>Devam Ediyor</option>
<option>Parça Bekleniyor</option>
<option>Tamamlandı</option>
</select>

<select class="filter-select" id="filterCihaz" onchange="filterForms()">
<option value="">Tüm Cihazlar</option>
<option>Lazer Epilasyon</option>
<option>Fractional Lazer</option>
<option>Ultrason</option>
<option>Röntgen</option>
<option>Dövme Silme Cihazı</option>
<option>Angiografi</option>
<option>Laboratuvar Cihazı</option>
<option>Diğer</option>
</select>

<select class="filter-select" id="filterTarih" onchange="filterForms()">
<option value="">Tüm Tarihler</option>
<option value="today">Bugün</option>
<option value="week">Bu Hafta</option>
<option value="month">Bu Ay</option>
</select>
</div>
</div>

<div class="results-info" id="resultsInfo">Yükleniyor...</div>
<div class="forms-list" id="formsList"></div>
</div>

<!-- Rapor Sekmesi -->
<div id="reportTab" class="report-section">
<div class="report-header">
<h2 class="report-title">📊 Aylık Cari Rapor</h2>
<div class="month-selector">
<label>Ay Seçin:</label>
<input type="month" id="reportMonth" onchange="generateReport()">
</div>
</div>

<div class="summary-cards">
<div class="summary-card">
<h3>Toplam İşlem</h3>
<div class="number" id="totalIslem">0</div>
<div class="label">Adet</div>
</div>
<div class="summary-card revenue">
<h3>Toplam Ciro</h3>
<div class="number" id="totalCiro">0 ₺</div>
<div class="label">Tahmini</div>
</div>
<div class="summary-card completed">
<h3>Tamamlanan</h3>
<div class="number" id="completedCount">0</div>
<div class="label">Adet</div>
</div>
<div class="summary-card pending">
<h3>Bekleyen</h3>
<div class="number" id="pendingCount">0</div>
<div class="label">Adet</div>
</div>
</div>

<table class="report-table">
<thead>
<tr>
<th>Tarih</th>
<th>Müşteri</th>
<th>Cihaz</th>
<th>İşlem</th>
<th>Durum</th>
<th class="tutar">Tutar</th>
</tr>
</thead>
<tbody id="reportTableBody">
<tr>
<td colspan="6" style="text-align: center; padding: 40px; color: #999;">
Ay seçerek rapor görüntüleyin
</td>
</tr>
</tbody>
</table>
</div>

<!-- Form Düzenleme -->
<div id="editForm" class="form-section">
<div class="section">
<h2 class="section-title">Müşteri Bilgileri</h2>
<div class="form-row two-col">
<div class="form-group">
<label>Firma / Kişi Adı</label>
<input type="text" id="musteriAdi" oninput="autoSave()">
</div>
<div class="form-group">
<label>Telefon</label>
<input type="tel" id="telefon" oninput="autoSave()">
</div>
</div>
</div>

<div class="section">
<h2 class="section-title">Cihaz Bilgileri</h2>
<div class="form-row">
<div class="form-group">
<label>Cihaz Türü</label>
<select id="cihazTuru" onchange="autoSave()">
<option value="">Seçiniz...</option>
<option>Lazer Epilasyon</option>
<option>Fractional Lazer</option>
<option>Ultrason</option>
<option>Röntgen</option>
<option>Dövme Silme Cihazı</option>
<option>Angiografi</option>
<option>Laboratuvar Cihazı</option>
<option>Diğer</option>
</select>
</div>
<div class="form-group">
<label>Marka / Model</label>
<input type="text" id="markaModel" oninput="autoSave()">
</div>
<div class="form-group">
<label>Seri No</label>
<input type="text" id="seriNo" oninput="autoSave()">
</div>
</div>
</div>

<div class="section">
<h2 class="section-title">Servis Bilgileri & Cari</h2>
<div class="form-row">
<div class="form-group">
<label>Durum</label>
<select id="durum" onchange="autoSave()">
<option>Beklemede</option>
<option>Devam Ediyor</option>
<option>Parça Bekleniyor</option>
<option>Tamamlandı</option>
</select>
</div>
<div class="form-group">
<label>Bildirim Tarihi</label>
<input type="date" id="bildirimTarihi" onchange="autoSave()">
</div>
<div class="form-group">
<label>İşlem Tutarı (₺)</label>
<input type="number" id="islemTutari" placeholder="0.00" oninput="autoSave()">
</div>
</div>
<div class="form-group" style="margin-top: 10px;">
<label>Yapılan İşlem / Arıza</label>
<textarea id="sikayet" oninput="autoSave()"></textarea>
</div>
</div>

<div class="actions">
<button class="btn btn-secondary" onclick="showList()">← Listeye Dön</button>
<button class="btn btn-primary" onclick="yazdir()">🖨️ Yazdır</button>
</div>
</div>
</div>

<script>
// Firebase yapılandırması
const firebaseConfig = {
apiKey: "AIzaSyDYDiVYGJWYWKHZi7T24Fk2xuBm4g6JiNI",
authDomain: "ebomedikal-80da4.firebaseapp.com",
databaseURL: "https://ebomedikal-80da4-default-rtdb.europe-west1.firebasedatabase.app",
projectId: "ebomedikal-80da4",
storageBucket: "ebomedikal-80da4.firebasestorage.app",
messagingSenderId: "542996689822",
appId: "1:542996689822:web:b8b602ad3d0d46e1b61c8f"
};

let database;
let allForms = {};
let currentFormId = null;
let saveTimeout = null;

try {
firebase.initializeApp(firebaseConfig);
database = firebase.database();
document.getElementById('statusIndicator').classList.add('online');
loadAllForms();

// Bugünün ayını rapor için ayarla
document.getElementById('reportMonth').value = new Date().toISOString().slice(0, 7);
} catch(e) {
console.error("Firebase hatası:", e);
}

function loadAllForms() {
database.ref('servisForms').on('value', (snapshot) => {
allForms = snapshot.val() || {};
filterForms();
});
}

// Tab değiştirme
function showTab(tab) {
document.querySelectorAll('.tab-btn').forEach(btn => btn.classList.remove('active'));
document.querySelectorAll('.list-section, .report-section').forEach(el => el.classList.remove('active'));

if (tab === 'list') {
document.querySelector('.tab-btn:nth-child(1)').classList.add('active');
document.getElementById('listTab').classList.add('active');
filterForms();
} else {
document.querySelector('.tab-btn:nth-child(2)').classList.add('active');
document.getElementById('reportTab').classList.add('active');
generateReport();
}
}

// Aylık rapor oluştur
function generateReport() {
const month = document.getElementById('reportMonth').value;
if (!month) return;

const [year, monthNum] = month.split('-');
const startDate = new Date(year, monthNum - 1, 1);
const endDate = new Date(year, monthNum, 0);

let totalCiro = 0;
let completed = 0;
let pending = 0;
let islemSayisi = 0;
let reportData = [];

Object.keys(allForms).forEach(key => {
const form = allForms[key];
if (!form.bildirimTarihi) return;

const formDate = new Date(form.bildirimTarihi);
if (formDate >= startDate && formDate <= endDate) {
islemSayisi++;
const tutar = parseFloat(form.islemTutari) || 0;
totalCiro += tutar;

if (form.durum === 'Tamamlandı') completed++;
else pending++;

reportData.push({
tarih: formDate.toLocaleDateString('tr-TR'),
musteri: form.musteriAdi || 'İsimsiz',
cihaz: form.cihazTuru || '-',
islem: form.sikayet ? form.sikayet.substring(0, 30) + '...' : '-',
durum: form.durum,
tutar: tutar
});
}
});

// Özet kartları güncelle
document.getElementById('totalIslem').textContent = islemSayisi;
document.getElementById('totalCiro').textContent = totalCiro.toLocaleString('tr-TR') + ' ₺';
document.getElementById('completedCount').textContent = completed;
document.getElementById('pendingCount').textContent = pending;

// Tabloyu doldur
const tbody = document.getElementById('reportTableBody');
tbody.innerHTML = '';

if (reportData.length === 0) {
tbody.innerHTML = '<tr><td colspan="6" style="text-align: center; padding: 40px; color: #999;">Bu ay kayıt bulunamadı</td></tr>';
return;
}

// Tarihe göre sırala
reportData.sort((a, b) => new Date(a.tarih) - new Date(b.tarih));

reportData.forEach(row => {
const tr = document.createElement('tr');
const durumClass = row.durum === 'Tamamlandı' ? 'durum-tamamlandi' : 'durum-beklemede';
tr.innerHTML = `
<td>${row.tarih}</td>
<td>${row.musteri}</td>
<td>${row.cihaz}</td>
<td>${row.islem}</td>
<td class="${durumClass}">${row.durum}</td>
<td class="tutar">${row.tutar.toLocaleString('tr-TR')} ₺</td>
`;
tbody.appendChild(tr);
});

// Toplam satırı
const totalRow = document.createElement('tr');
totalRow.className = 'total-row';
totalRow.innerHTML = `
<td colspan="5" style="text-align: right;">TOPLAM:</td>
<td class="tutar">${totalCiro.toLocaleString('tr-TR')} ₺</td>
`;
tbody.appendChild(totalRow);
}

// Arama ve filtreleme (önceki kod ile aynı)
function filterForms() {
const searchTerm = document.getElementById('searchInput').value.toLowerCase();
const durumFilter = document.getElementById('filterDurum').value;
const cihazFilter = document.getElementById('filterCihaz').value;
const tarihFilter = document.getElementById('filterTarih').value;

const list = document.getElementById('formsList');
list.innerHTML = '';

let filtered = Object.keys(allForms).filter(key => {
const form = allForms[key];

const matchesSearch = !searchTerm ||
(form.musteriAdi && form.musteriAdi.toLowerCase().includes(searchTerm)) ||
(form.telefon && form.telefon.includes(searchTerm)) ||
(form.cihazTuru && form.cihazTuru.toLowerCase().includes(searchTerm)) ||
key.toLowerCase().includes(searchTerm);

const matchesDurum = !durumFilter || form.durum === durumFilter;
const matchesCihaz = !cihazFilter || form.cihazTuru === cihazFilter;

let matchesTarih = true;
if (tarihFilter && form.bildirimTarihi) {
const formDate = new Date(form.bildirimTarihi);
const today = new Date();
if (tarihFilter === 'today') {
matchesTarih = formDate.toDateString() === today.toDateString();
} else if (tarihFilter === 'week') {
const weekAgo = new Date(today - 7 * 24 * 60 * 60 * 1000);
matchesTarih = formDate >= weekAgo;
} else if (tarihFilter === 'month') {
matchesTarih = formDate.getMonth() === today.getMonth() &&
formDate.getFullYear() === today.getFullYear();
}
}

return matchesSearch && matchesDurum && matchesCihaz && matchesTarih;
});

filtered.sort((a, b) => (allForms[b].sonGuncelleme || 0) - (allForms[a].sonGuncelleme || 0));

document.getElementById('resultsInfo').textContent =
`${filtered.length} kayıt bulundu (Toplam: ${Object.keys(allForms).length})`;

if (filtered.length === 0) {
list.innerHTML = '<div class="no-results">Kayıt bulunamadı</div>';
return;
}

filtered.forEach(key => {
const form = allForms[key];
const div = document.createElement('div');
div.className = 'form-item';
div.onclick = () => editForm(key);

const statusClass = form.durum === 'Tamamlandı' ? 'status-tamamlandi' :
form.durum === 'Devam Ediyor' ? 'status-devam' :
form.durum === 'Parça Bekleniyor' ? 'status-parca' : 'status-beklemede';

const date = form.bildirimTarihi ? new Date(form.bildirimTarihi).toLocaleDateString('tr-TR') : '-';
const tutar = form.islemTutari ? parseFloat(form.islemTutari).toLocaleString('tr-TR') + ' ₺' : '-';

div.innerHTML = `
<div class="form-item-header">
<span class="form-item-title">${form.musteriAdi || 'İsimsiz'}</span>
<span class="form-item-id">${key.slice(-8)}</span>
</div>
<div class="form-item-details">
<span>📞 ${form.telefon || '-'}</span>
<span>🔧 ${form.cihazTuru || '-'}</span>
<span>📅 ${date}</span>
<span>💰 ${tutar}</span>
</div>
<span class="form-item-status ${statusClass}">${form.durum}</span>
`;

list.appendChild(div);
});
}

function searchForms(event) {
if (event && event.key !== 'Enter') return;
filterForms();
}

function editForm(formId) {
currentFormId = formId;
const form = allForms[formId];

document.getElementById('musteriAdi').value = form.musteriAdi || '';
document.getElementById('telefon').value = form.telefon || '';
document.getElementById('cihazTuru').value = form.cihazTuru || '';
document.getElementById('markaModel').value = form.markaModel || '';
document.getElementById('seriNo').value = form.seriNo || '';
document.getElementById('durum').value = form.durum || 'Beklemede';
document.getElementById('bildirimTarihi').value = form.bildirimTarihi || '';
document.getElementById('sikayet').value = form.sikayet || '';
document.getElementById('islemTutari').value = form.islemTutari || '';

document.getElementById('listTab').style.display = 'none';
document.getElementById('reportTab').style.display = 'none';
document.querySelector('.tab-menu').style.display = 'none';
document.getElementById('editForm').classList.add('active');
}

function showList() {
document.getElementById('editForm').classList.remove('active');
document.querySelector('.tab-menu').style.display = 'flex';
document.getElementById('listTab').style.display = 'block';
currentFormId = null;
filterForms();
}

function autoSave() {
if (!currentFormId) return;

clearTimeout(saveTimeout);
saveTimeout = setTimeout(() => {
const updates = {
musteriAdi: document.getElementById('musteriAdi').value,
telefon: document.getElementById('telefon').value,
cihazTuru: document.getElementById('cihazTuru').value,
markaModel: document.getElementById('markaModel').value,
seriNo: document.getElementById('seriNo').value,
durum: document.getElementById('durum').value,
bildirimTarihi: document.getElementById('bildirimTarihi').value,
sikayet: document.getElementById('sikayet').value,
islemTutari: document.getElementById('islemTutari').value,
sonGuncelleme: firebase.database.ServerValue.TIMESTAMP
};

database.ref('servisForms/' + currentFormId).update(updates);
}, 500);
}

function yazdir() {
window.print();
}
</script>
</body>
</html>

