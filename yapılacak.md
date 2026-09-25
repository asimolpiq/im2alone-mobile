
---

# Hesap silme + feed'de rapor/engelle menüsü (2026-09-25)

## Deploy edilecek backend dosyaları (`~/Desktop/im2alone`)
- `api/v1/delete-account.php` (mobil bu endpoint'i `{"password": ...}` body'siyle çağırıyor)
- `includes/account_delete.php`, `delete_account.php`, `account-deletion.php`
- Bunlar deploy edilmeden Hesabım > Hesabı Sil hata verir (App Store 5.1.1(v) için şart).
