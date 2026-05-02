# Mini Student Management System (Tələbə İdarəetmə Sistemi)

Bu layihə istifadəçi autentifikasiyası və məlumatların idarə edilməsi mexanizmlərini özündə birləşdirən ASP.NET WebForms tətbiqidir. Layihənin əsas hədəfi vizual interfeysdən daha çox arxa planda işləyən məntiqin (backend) qurulmasıdır. Xüsusilə verilənlər bazası serverlərindən istifadə etmədən məlumatların fayl səviyyəsində (JSON) təhlükəsiz və düzgün idarə olunması sistemin əsasını təşkil edir.

## 🛠️ İstifadə olunan texnologiyalar
* **Platforma:** ASP.NET WebForms, C#
* **Məlumatların Saxlanması:** JSON (Fayl əsaslı verilənlər bazası)
* **Vəziyyətin İdarəedilməsi (State Management):** Sessions, Cookies

## 📌 Əsas Xüsusiyyətlər və Arxitektura

**1. Təhlükəsiz Autentifikasiya və Avtorizasiya:**
* **Qeydiyyat (Register):** Yeni istifadəçilərin (Username, Password, Email) JSON faylına yazılması və eyni istifadəçi adının təkrar qeydiyyatının qarşısının alınması.
* **Giriş (Login):** Məlumatların JSON faylından oxunaraq yoxlanılması. Uğurlu giriş zamanı istifadəçi məlumatlarının həm **Session**, həm də **Cookie** vasitəsilə yadda saxlanması.
* **Səhifə Mühafizəsi:** Tələbə siyahısı səhifəsinə yalnız giriş etmiş (login olmuş) istifadəçilərin buraxılması.

**2. Tələbə İdarəetməsi (CRUD Əməliyyatları):**
* Qrupa daxil olan tələbələrin siyahısının JSON faylından oxunaraq ekrana çıxarılması (Ad, Soyad, Tələbə nömrəsi).
* Sistemə yeni tələbələrin əlavə edilməsi.
* Mövcud tələbə məlumatlarının redaktə olunması (Update).
* Siyahıdan tələbələrin silinməsi (Delete).

**3. Fayl Əsaslı İdarəetmə:**
* Bütün məlumat mübadiləsi SQL server olmadan, birbaşa JSON fayllarının oxunub-yazılması ilə həyata keçirilir.

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/ef62a547-d1c5-4edf-91c9-3855a3915988" />

<img width="1897" height="747" alt="image" src="https://github.com/user-attachments/assets/8a02242d-7ca5-45f1-a43c-05c996d91bca" />

<img width="1871" height="595" alt="image" src="https://github.com/user-attachments/assets/000326e7-c44b-416e-a586-fa8a654fc594" />

