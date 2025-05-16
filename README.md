# eTeatar_RS2
Seminarski rad iz predmeta Razvoj softvera 2 na Fakultetu informacijskih tehnologija u Mostaru

# Upute za pokretanje
- **Extractovati arhivu fit-build-05-16-env u folderima (eTeatar_RS2/eTeatar) i (eTeatar_RS2/eTeatar/UI/eteatar_mobile) radi extract-a env**
- **Otvoriti /eTeatar_RS2/eTeatar u terminalu i pokrenuti komandu docker compose up --build, te sačekati da se sve uspješno build-a.**
- **Extractovati arhivu fit-build-05-16-desktop (eTeatar_RS2/eTeatar), te otvoriti eteatar_desktop.exe iz foldera Release.**
- **Pokretanje mobilne aplikacije:**
     - Otvoriti flutter projekt u Visual Studio Code (eTeatar_RS2/eTeatar/UI/eteatar_mobile).
     - Pokrenuti iducu komandu:
       
       ```bash
       dart pub get
       ```
     
     - Pokrenuti emulator ( Android Studio emulator) .
     - Pokrenuti flutter mobilnu aplikaciju:
       
         ```bash
         flutter run
         ```
  
- **Nakon instaliranja obe aplikacije, iskoristiti kredencijale za uloge ispod.**
  
## Kredencijali za prijavu

### Administrator (desktop aplikacija):
- **Korisničko ime:** `admin`
- **Lozinka:** `test`

### Gledaoc (mobilna aplikacija):
- **Korisničko ime:** `mobile`
- **Lozinka:** `test`

## PayPal Kredencijali
- **Email:** `sb-iuiw4341588026@personal.example.com`
- **Lozinka:** `m'G>e2_S`
- **Plaćanje je omogućeno na ekranu rezervacija**

## Mikroservis
- **Rabbitmq je iskorišten za slanje e-maila prilikom registracije novog korisnika** 
  
