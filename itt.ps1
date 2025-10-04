param (
[string]$i
)
Add-Type -AssemblyName 'System.Windows.Forms', 'PresentationFramework', 'PresentationCore', 'WindowsBase','System.Net.Http'
$Host.UI.RawUI.WindowTitle = "Install Twaeks Tool"
$itt = [Hashtable]::Synchronized(@{
database       = @{}
ProcessRunning = $false
lastupdate     = "10/04/2025"
registryPath   = "HKCU:\Software\ITT@emadadel"
icon           = "https://raw.githubusercontent.com/emadadel4/ITT/main/static/Icons/icon.ico"
Theme          = "default"
Date           = (Get-Date -Format "MM/dd/yyy")
Language       = "default"
ittDir         = "$env:ProgramData\itt\"
command        = "$($MyInvocation.MyCommand.Definition)"
})
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
Start-Process -FilePath "PowerShell" -ArgumentList "-ExecutionPolicy Bypass -NoProfile -Command `"$($MyInvocation.MyCommand.Definition)`"" -Verb RunAs
exit
}
Write-Host "`n  Relax, good things are loading… almost there!" -ForegroundColor Yellow
if (-not (Test-Path -Path $itt.ittDir)) {New-Item -ItemType Directory -Path $itt.ittDir -Force | Out-Null}
Start-Transcript -Path (Join-Path $itt.ittDir "logs\log_$(Get-Date -Format 'yyyy-MM-dd').log") -Append -Force *> $null
$itt.database.locales = @'
{"Controls":{"ar":{"name":"عربي","Welcome":"توفر هذه الأداة تسهيلات كبيرة في عملية تثبيت البرامج وتحسين الويندوز. انضم إلينا وكن جزءًا في تطويرها","System_Info":"معلومات النظام","Power_Options":"خيارات الطاقة","Device_Manager":"إدارة الأجهزة","Services":"خدمات","Networks":"شبكات","Apps_features":"التطبيقات و الميزات","Task_Manager":"مدير المهام","Disk_Managment":"إدارة القرص","Msconfig":"تكوين النظام","Environment_Variables":"متغيرات بيئة النظام","Install":"تثبيت","Apply":"تطبيق","Downloading":"...جارٍ التحميل","About":"عن الاداة","Third_party":"ادوات اخرى","Preferences":"التفضيلات","Management":"إدارة الجهاز","Apps":"برامج","Tweaks":"تحسينات","Settings":"إعدادات","Save":"حفظ البرامج","Restore":"أسترجاع البرامج","On":"تشغيل ","Off":"إيقاف","Dark":"ليلا","Light":"نهارا","Use_system_setting":"استخدم إعدادات النظام","Create_desktop_shortcut":"أنشاء أختصار على سطح المكتب","Reset_preferences":"إعادة التفضيلات إلى الوضع الافتراضي","Reopen_itt_again":"يرجى اعادة فتح الاداة مرة اخرى","Theme":"المظهر","Language":"اللغة","Browsers_extensions":"أضافات المتصفحات","All":"الكل","Search":"بحث","Create_restore_point":"إنشاء نقطة الاستعادة","Portable_Downloads_Folder":"مجلد التنزيلات المحمولة","Install_msg":"هل تريد تثبيت البرامج التالية","Apply_msg":"هل تريد تطبيق التحسينات التالية","Applying":"...جارٍي التطبيق","Please_wait":"يرجى الانتظار، يوجد عملية في الخلفية","Last_update":"آخر تحديث","Exit_msg":"هل أنت متأكد من رغبتك في إغلاق البرنامج؟ إذا كان هناك أي تثبيتات، فسيتم إيقافها.","Empty_save_msg":"يرجى اختيار تطبيق واحد على الاقل لحفظه","easter_egg":"تقدر تكتشف الميزة المخفية؟ تصفح الكود، وكن أول واحد يكتشف الميزة، ويضيفها للأداة","system_protection":"حماية النظام","web browsers":"متصفحات","media":"مشغل","media tools":"أدوات الفيديو","documents":"المستندات","compression":"الضغط","communication":"الاتصال","file sharing":"مشاركة الملفات","imaging":"صور","gaming":"ألعاب","utilities":"أدوات النظام","disk tools":"أدوات القرص","development":"تطوير","security":"حماية","portable":"محمولة","runtimes":"مكاتب","drivers":"تعريفات","privacy":"الخصوصية","fixer":"المصحح","performance":"الأداء","personalization":"التخصيص","power":"الطاقة","protection":"حماية","classic":"كلاسيكي","auto":"تلقائي","package_manager":"مدير الحزم","DisablePopupText":"اظهار عند التحديث"},"de":{"name":"Deutsch","Welcome":"Sparen Sie Zeit indem Sie mehrere Programme gleichzeitig instAllieren und die Leistung Ihres Windows steigern. Schließen Sie sich uns an um dieses Tool zu verbessern und noch besser zu machen. Sie können auch Ihre Lieblings-Musik-Apps und Anpassungen hinzufügen.","Install":"InstAllieren","Apply":"Anwenden","Downloading":"Herunterladen...","About":"Über","Third_party":"Drittanbieter","Preferences":"Einstellungen","Management":"Verwaltung","Apps":"Apps","Tweaks":"Optimierungen","Settings":"Einstellungen","Save":"Speichern","Restore":"Wiederherstellen","On":"Ein","Off":"Aus","Disk_Managment":"Datenträgerverwaltung","Msconfig":"Systemkonfiguration","Environment_Variables":"Umgebungsvariablen","Task_Manager":"Task-Manager","Apps_features":"Apps-FunktiOnen","Networks":"Netzwerke","Services":"Dienste","Device_Manager":"Geräte-Manager","Power_Options":"EnergieoptiOnen","System_Info":"Systeminfo","Use_system_setting":"Systemeinstellungen verwenden","Create_desktop_shortcut":"Desktop-Verknüpfung erstellen","Reset_preferences":"Einstellungen zurücksetzen","Reopen_itt_again":"Bitte ITT erneut öffnen.","Theme":"Thema","Language":"Sprache","Browsers_extensions":"Browser-Erweiterungen","All":"Alle","Search":"Suchen","Create_restore_point":"Wiederherstellungspunkt erstellen","Portable_Downloads_Folder":"Ordner für tragbare Downloads","Install_msg":"Sind Sie sicher  dass Sie die folgenden Anwendungen instAllieren möchten?","Apply_msg":"Sind Sie sicher dass Sie die folgenden Anpassungen anwenden möchten?","Applying":"Anwenden...","Please_wait":"Bitte warten ein Prozess läuft im Hintergrund","Last_update":"Letztes Update","Exit_msg":"Sind Sie sicher dass Sie das Programm schließen möchten? Alle InstAllatiOnen werden abgebrochen.","Empty_save_msg":"Wählen Sie mindestens eine App zum Speichern aus","easter_egg":"Kannst du das verborgene Geheimnis entdecken? Tauche in den Quellcode ein sei der erste der die Funktion entdeckt und integriere sie in das Tool","system_protection":"Systemschutz","web browsers":"Webbrowser","media":"Medien","media tools":"Medienwerkzeuge","documents":"Dokumente","compression":"Komprimierung","communication":"Kommunikation","file sharing":"Dateifreigabe","imaging":"Bildbearbeitung","gaming":"Spiele","utilities":"Dienstprogramme","disk tools":"Laufwerkswerkzeuge","development":"Entwicklung","security":"Sicherheit","portable":"Tragbar","runtimes":"Laufzeitumgebungen","drivers":"Treiber","privacy":"Datenschutz","fixer":"Reparierer","performance":"Leistung","personalization":"Personalisierung","power":"Energie","protection":"Schutz","classic":"Klassisch","auto":"automatisch","package_manager":"Manager der Pakete","DisablePopupText":"Beim Update anzeigen"},"en":{"name":"English","Welcome":"Save time and install all your programs at once and debloat Windows and more. Be part of ITT and contribute to improving it","Install":"Install","Apply":"Apply","Downloading":"Downloading...","About":"About","Third_party":"Third-party","Preferences":"Preferences","Management":"Management","Apps":"Apps","Tweaks":"Tweaks","Settings":"Settings","Save":"Save","Restore":"Restore","On":"On","Off":"Off","Disk_Managment":"Disk Managment","Msconfig":"System Configuration","Environment_Variables":"Environment Variables","Task_Manager":"Task Manager","Apps_features":"Programs and Features","Networks":"Networks","Services":"Services","Device_Manager":"Device Manager","Power_Options":"Power options","System_Info":"System Info","Use_system_setting":"Use system setting","Create_desktop_shortcut":"Create desktop shortcut","Reset_preferences":"Reset Preferences","Reopen_itt_again":"Please reopen itt again.","Theme":"Theme","Language":"Language","Browsers_extensions":"Browsers extensions","All":"All","Search":"Search","Create_restore_point":"Create a restore point","Portable_Downloads_Folder":"Portable Downloads Folder","Install_msg":"Are you sure you want to install the following App(s)","Apply_msg":"Are you sure you want to apply the following Tweak(s)","Applying":"Applying...","Please_wait":"Please wait a process is running in the background","Last_update":"Last update","Exit_msg":"Are you sure you want to close the program? Any ongoing installations will be canceled","Empty_save_msg":"Choose at least One app to save it","easter_egg":"Can you uncover the hidden secret? Dive into the source code be the first to discover the feature and integrate it into the tool","system_protection":"System protection","web browsers":"Web Browsers","media":"Media","media tools":"Media Tools","documents":"Documents","compression":"Compression","communication":"Communication","file sharing":"File Sharing","imaging":"Imaging","gaming":"Gaming","utilities":"Utilities","disk tools":"Disk Tools","development":"Development","security":"Security","portable":"Portable","runtimes":"Runtimes","drivers":"Drivers","privacy":"Privacy","fixer":"Fixer","performance":"Performance","personalization":"Personalization","power":"Power","protection":"Protection","classic":"Classic","auto":"Auto","package_manager":"Package Manager","DisablePopupText":"Show on update"},"es":{"name":"Español","Welcome":"Ahorra tiempo instalando varios prograMAS a la vez y mejora el rendimiento de tu Windows. Únete a nosotros para mejorar esta herramienta y hacerla aún mejor. También puedes agregar tus aplicaciOnes Musicales y ajustes favoritos.","Install":"Instalar","Apply":"Aplicar","Downloading":"Descargando...","About":"Acerca de","Third_party":"Terceros","Preferences":"Preferencias","Management":"Gestión","Apps":"AplicaciOnes","Tweaks":"Ajustes","Settings":"COnfiguración","Save":"Guardar","Restore":"Restaurar","On":"Encendido","Off":"Apagado","Disk_Managment":"Administración de discos","Msconfig":"Configuración del sistema","Environment_Variables":"Variables de entorno","Task_Manager":"Administrador de tareas","Apps_features":"AplicaciOnes-FunciOnes","Networks":"Redes","Services":"Servicios","Device_Manager":"Administrador de dispositivos","Power_Options":"OpciOnes de energía","System_Info":"Información del sistema","Use_system_setting":"Usar la cOnfiguración del sistema","Create_desktop_shortcut":"Crear acceso directo en el escritorio","Reset_preferences":"Restablecer preferencias","Reopen_itt_again":"Vuelve a abrir ITT.","Theme":"Tema","Language":"Idioma","Browsers_extensions":"ExtensiOnes del navegador","All":"Todos","Search":"Buscar","Create_restore_point":"Crear un punto de restauración","Portable_Downloads_Folder":"Carpeta de descargas portátiles","Install_msg":"¿Estás seguro de que deseas instalar las siguientes aplicaciOnes?","Apply_msg":"¿Estás seguro de que deseas aplicar los siguientes ajustes?","Applying":"Aplicando...","Please_wait":"Por favorespera un proceso se está ejecutando en segundo plano.","Last_update":"Última actualización","Exit_msg":"¿Estás seguro de que deseas cerrar el programa? Si hay instalaciOnes se interrumpirán.","Empty_save_msg":"Elige al menos una aplicación para guardarla.","easter_egg":"¿Puedes descubrir el secreto oculto? Sumérgete en el código fuente sé el primero en descubrir la función e intégrala en la herramienta","system_protection":"Protección del sistema","web browsers":"Navegadores web","media":"Medios","media tools":"Herramientas multimedia","documents":"Documentos","compression":"Compresión","communication":"Comunicación","file sharing":"Compartición de archivos","imaging":"Imágenes","gaming":"Juegos","utilities":"Utilidades","disk tools":"Herramientas de disco","development":"Desarrollo","security":"Seguridad","portable":"Portátil","runtimes":"Runtimes","drivers":"Controladores","privacy":"Privacidad","fixer":"Reparador","performance":"Rendimiento","personalization":"Personalización","power":"Potencia","protection":"Protección","classic":"Clásico","auto":"automático","package_manager":"Manager de paquetes","DisablePopupText":"Mostrar en la actualización"},"fr":{"name":"Français","Welcome":"Gagnez du temps en instAllant plusieurs programmes à la fois et améliorez les performances de votre Windows. Rejoignez-nous pour améliorer cet outil et le rendre encore meilleur. Vous pouvez également ajouter vos applicatiOns Musicales et vos Tweaks préférés.","Install":"InstAller","Apply":"Appliquer","Downloading":"Téléchargement...","About":"À propos","Third_party":"Tiers","Preferences":"Préférences","Management":"GestiOn","Apps":"ApplicatiOns","Tweaks":"OptimisatiOns","Settings":"Paramètres","Save":"Sauvegarder","Restore":"Restaurer","On":"Activé","Off":"Désactivé","Disk_Managment":"GestiOn des disques","Msconfig":"Configuration du système","Environment_Variables":"Variables d'environnement","Task_Manager":"GestiOnnaire des tâches","Apps_features":"ApplicatiOns-FOnctiOnnalités","Networks":"Réseaux","Services":"Services","Device_Manager":"GestiOnnaire de périphériques","Power_Options":"OptiOns d'alimentatiOn","System_Info":"Infos système","Use_system_setting":"Utiliser les paramètres système","Create_desktop_shortcut":"Créer un raccourci sur le bureau","Reset_preferences":"Réinitialiser les préférences","Reopen_itt_again":"Veuillez rouvrir ITT.","Theme":"Thème","Language":"Langue","Browsers_extensions":"Browsers_extensions de navigateurs","All":"Tout","Search":"Rechercher","Create_restore_point":"Créer un point de restauratiOn","Portable_Downloads_Folder":"Dossier de téléchargements portables","Install_msg":"Êtes-vous sûr de vouloir instAller les applicatiOns suivantes ?","Apply_msg":"Êtes-vous sûr de vouloir appliquer les Tweaks suivants ?","Applying":"ApplicatiOn...","Please_wait":"Veuillez patienter","Last_update":"Dernière mise à jour  un processus est en cours d'exécutiOn en arrière-plan.","Exit_msg":"Êtes-vous sûr de vouloir fermer le programme ? Si des instAllatiOns sOnt en cours  elles serOnt interrompues","Empty_save_msg":"Choisissez au moins une applicatiOn à sauvegarder","easter_egg":"Peux-tu découvrir le secret caché ? Plonge dans le code source sois le premier à découvrir la fonctionnalité et intègre-la dans l'outil","system_protection":"Protection du système","web browsers":"Navigateurs Web","media":"Médias","media tools":"Outils multimédias","documents":"Documents","compression":"Compression","communication":"Communication","file sharing":"Partage de fichiers","imaging":"Imagerie","gaming":"Jeux","utilities":"Utilitaires","disk tools":"Outils de disque","development":"Développement","security":"Sécurité","portable":"Portable","runtimes":"Runtimes","drivers":"Pilotes","privacy":"Confidentialité","fixer":"Réparateur","performance":"Performance","personalization":"Personnalisation","power":"Puissance","protection":"Protection","classic":"Classique","auto":"automatique","package_manager":"Manager des paquets","DisablePopupText":"Afficher lors de la mise à jour"},"hi":{"name":"अंग्रेज़ी","Welcome":"एक बार में कई प्रोग्राम इंस्टॉल करके समय बचाएं और अपने विंडोज़ के प्रदर्शन को बढ़ावा दें। इस टूल को बेहतर बनाने और इसे और अच्छा बनाने में हमारा साथ दें। आप अपने पसंदीदा म्यूज़िक ऐप्स और ट्विक्स भी जोड़ सकते हैं।","Install":"इंस्टॉल करें","Apply":"लागू करें","Downloading":"डाउनलोड हो रहा है...","About":"के बारे में","Third_party":"थर्ड-पार्टी","Preferences":"पसंद","Management":"प्रबंधन","Apps":"ऐप्स","Tweaks":"ट्विक्स","Settings":"सेटिंग्स","Save":"सहेजें","Restore":"पुनर्स्थापित करें","On":"चालू","Off":"बंद","Disk_Managment":"डिस्क प्रबंधन","Msconfig":"सिस्टम कॉन्फ़िगरेशन","Environment_Variables":"एन्विर्बल वार्डियल्स","Task_Manager":"टास्क मैनेजर","Apps_features":"ऐप्स-फीचर्स","Networks":"नेटवर्क्स","Services":"सेवाएँ","Device_Manager":"डिवाइस मैनेजर","Power_Options":"पावर विकल्प","System_Info":"सिस्टम जानकारी","Use_system_setting":"सिस्टम सेटिंग का उपयोग करें","Create_desktop_shortcut":"डेस्कटॉप शॉर्टकट बनाएं","Reset_preferences":"पसंद रीसेट करें","Reopen_itt_again":"कृपया इसे फिर से खोलें।","Theme":"थीम","Language":"भाषा","Browsers_extensions":"ब्राउज़र एक्सटेंशन","All":"सभी","Search":"खोज","Create_restore_point":"पुनर्स्थापना बिंदु बनाएँ","Portable_Downloads_Folder":"पोर्टेबल डाउनलोड फ़ोल्डर","Install_msg":"क्या आप निश्चित हैं कि आप निम्न ऐप्स इंस्टॉल करना चाहते हैं?","Apply_msg":"क्या आप निश्चित हैं कि आप निम्न ट्विक्स लागू करना चाहते हैं?","Applying":"लागू किया जा रहा है...","Please_wait":"कृपया प्रतीक्षा करें बैकग्राउंड में एक प्रक्रिया चल रही है","Last_update":"आखिरी अपडेट","Exit_msg":"क्या आप निश्चित हैं कि आप प्रोग्राम बंद करना चाहते हैं? यदि कोई इंस्टॉलेशन चल रहा हो तो वह समाप्त हो जाएगा","Empty_save_msg":"कम से कम एक ऐप चुनें और उसे सहेजें।","easter_egg":"क्या आप छिपे हुए रहस्य को उजागर कर सकते हैं? सोर्स कोड में डूबकी लगाएं पहले व्यक्ति बनें जो फीचर को खोजे और इसे टूल में इंटीग्रेट करें","system_protection":"सिस्टम सुरक्षा","web browsers":"वेब ब्राउज़र","media":"मीडिया","media tools":"मीडिया उपकरण","documents":"दस्तावेज़","compression":"संपीड़न","communication":"संचार","file sharing":"फ़ाइल साझा करना","imaging":"इमेजिंग","gaming":"गेमिंग","utilities":"उपयोगिताएँ","disk tools":"डिस्क उपकरण","development":"विकास","security":"सुरक्षा","portable":"पोर्टेबल","runtimes":"रनटाइम्स","drivers":"ड्राइवर","privacy":"गोपनीयता","fixer":"ठीक करने वाला","performance":"प रदर्शन","personalization":"वैयक्तिकरण","power":"शक्ति","protection":"सुरक्षा","classic":"क्लासिक","auto":"स्वचालित","package_manager":"पैकेज मैनेजर","DisablePopupText":"अपडेट पर दिखाएँ"},"it":{"name":"Italiano","Welcome":"Risparmia tempo installando più programmi contemporaneamente e migliora le prestazioni di Windows. Unisciti a noi per migliorare questo strumento e renderlo migliore. Puoi anche aggiungere le tue app musicali preferite e le personalizzazioni.","Install":"Installa","Apply":"Applica","Downloading":"Download in corso...","About":"Informazioni","Third_party":"Terze parti","Preferences":"Preferenze","Management":"Gestione","Apps":"App","Tweaks":"Personalizzazioni","Settings":"Impostazioni","Save":"Salva","Restore":"Ripristina","On":"Acceso","Off":"Spento","Disk_Managment":"Gestione disco","Msconfig":"Configurazione di sistema","Environment_Variables":"Variabili di ambiente","Task_Manager":"Gestore attività","Apps_features":"App-Funzionalità","Networks":"Reti","Services":"Servizi","Device_Manager":"Gestore dispositivi","Power_Options":"Opzioni risparmio energia","System_Info":"Informazioni di sistema","Use_system_setting":"Usa impostazioni di sistema","Create_desktop_shortcut":"Crea collegamento sul desktop","Reset_preferences":"Reimposta preferenze","Reopen_itt_again":"Per favore riapri di nuovo.","Theme":"Tema","Language":"Lingua","Browsers_extensions":"Estensioni per browser","All":"Tutti","Search":"Cerca","Create_restore_point":"Crea un punto di ripristino","Portable_Downloads_Folder":"Cartella download portatile","Install_msg":"Sei sicuro di voler installare le seguenti app?","Apply_msg":"Sei sicuro di voler applicare le seguenti personalizzazioni?","Applying":"Applicazione in corso...","Please_wait":"Attendere un processo è in corso in background","Last_update":"Ultimo aggiornamento","Exit_msg":"Sei sicuro di voler chiudere il programma? Se ci sono installazioni in corso verranno terminate.","Empty_save_msg":"Scegli almeno un'app per salvarla.","easter_egg":"Riuscirai a scoprire il segreto nascosto? Tuffati nel codice sorgente sii il primo a scoprire la funzionalità e integrala nello strumento","system_protection":"Protezione del sistema","web browsers":"Browser Web","media":"Media","media tools":"Strumenti Media","documents":"Documenti","compression":"Compressione","communication":"Comunicazione","file sharing":"Condivisione File","imaging":"Imaging","gaming":"Giochi","utilities":"Utilità","disk tools":"Strumenti Disco","development":"Sviluppo","security":"Sicurezza","portable":"Portatile","runtimes":"Runtime","drivers":"Driver","privacy":"Privacy","fixer":"Riparatore","performance":"Prestazioni","personalization":"Personalizzazione","power":"Potenza","protection":"Protezione","classic":"Classico","auto":"automatico","package_manager":"Gestore pacchetti","DisablePopupText":"Mostra all aggiornamento"},"ko":{"name":"한국어","Welcome":"여러 프로그램을 한 번에 설치하여 시간을 절약하고 Windows 성능을 향상시킵니다. 도구를 개선하고 우리와 함께 훌륭하게 만들어 보세요.","System_Info":"시스템 정보","Power_Options":"전원 옵션","Device_Manager":"장치 관리자","Services":"서비스","Networks":"네트워크","Apps_features":"앱 기능","Task_Manager":"작업 관리자","Disk_Managment":"디스크 관리","Msconfig":"시스템 구성","Environment_Variables":"연습별 변수","Install":"설치","Apply":"적용","Downloading":"다운로드 중","About":"정보","Third_party":"외부","Preferences":"환경 설정","Management":"관리","Apps":"앱","Tweaks":"설정","Settings":"설정","Save":"선택한 앱 저장","Restore":"선택한 앱 복원","On":"켜기","Reset_preferences":"환경 설정 초기화","Off":"끄기","Dark":"다크","Light":"라이트","Use_system_setting":"시스템","Create_desktop_shortcut":"바탕화면 바로 가기 만들기","Reopen_itt_again":"ITT를 다시 열어주세요.","Theme":"테마","Language":"언어","Browsers_extensions":"브라우저 확장 프로그램","All":"모두","Create_restore_point":"복원 지점 생성","Portable_Downloads_Folder":"휴대용 다운로드 폴더","Install_msg":"선택한 앱을 설치하시겠습니까","Apply_msg":"선택한 조정 사항을 적용하시겠습니까","instAlling":"설치 중..","Applying":"적용 중..","Please_wait":"배경에서 프로세스가 진행 중입니다. 잠시 기다려주세요.","Last_update":"마지막 업데이트","Exit_msg":"프로그램을 종료하시겠습니까? 진행 중인 설치가 있으면 중단됩니다.","easter_egg":"숨겨진 비밀을 발견할 수 있습니다. 소스 코드에 뛰어들고 최초로 기능을 발견하고 도구에 통합하세요","system_protection":"웹 보호","web browsers":"웹 브라우저","media":"미디어","media tools":"미디어 도구","documents":"문서","compression":"압축","communication":"커뮤니케이션","file sharing":"파일 공유","imaging":"이미지 처리","gaming":"게임","utilities":"유틸리티","disk tools":"디스크 도구","development":"개발","security":"보호","portable":"포터블","runtimes":"런타임","drivers":"드라이버","privacy":"개인 정보 보호","fixer":"수리공","performance":"성능","personalization":"개인화","power":"전력","protection":"보호","classic":"클래식","auto":"자동","package_manager":"패키지 관리자","DisablePopupText":"업데이트 시 표시"},"ru":{"name":"Русский","Welcome":"Сэкономьте время устанавливая несколько программ одновременно и улучшите производительность Windows. Присоединяйтесь к нам для улучшения этого инструмента и его совершенствования. Вы также можете добавить свои любимые музыкальные приложения и настройки.","Install":"Установить","Apply":"Применить","Downloading":"Загрузка...","About":"О нас","Third_party":"Сторонние","Preferences":"Настройки","Management":"Управление","Apps":"Приложения","Tweaks":"Настройки","Settings":"Параметры","Save":"Сохранить","Restore":"Восстановить","On":"Вкл","Off":"Выкл","Disk_Managment":"Управление дисками","Msconfig":"Конфигурация системы","Environment_Variables":"Переменные окружения","Task_Manager":"Диспетчер задач","Apps_features":"Приложения-Функции","Networks":"Сети","Services":"Сервисы","Device_Manager":"Диспетчер устройств","Power_Options":"Энергопитание","System_Info":"Информация о системе","Use_system_setting":"Использовать системные настройки","Create_desktop_shortcut":"Создать ярлык на рабочем столе","Reset_preferences":"Сбросить настройки","Reopen_itt_again":"Пожалуйста перезапустите ITT.","Theme":"Тема","Language":"Язык","Browsers_extensions":"Расширения для браузеров","All":"Все","Search":"Поиск","Create_restore_point":"Создать точку восстановления","Portable_Downloads_Folder":"Папка для портативных загрузок","Install_msg":"Вы уверены что хотите установить следующие приложения?","Apply_msg":"Вы уверены что хотите применить следующие настройки?","Applying":"Применение...","Please_wait":"Подождите выполняется фоновый процесс.","Last_update":"Последнее обновление","Exit_msg":"Вы уверены что хотите закрыть программу? Все установки будут прерваны.","Empty_save_msg":"Выберите хотя бы одно приложение для сохранения","easter_egg":"Можешь ли ты раскрыть скрытый секрет? Погрузись в исходный код стань первым кто обнаружит функцию и интегрируй её в инструмент","system_protection":"Системная защита","web browsers":"Веб-браузеры","media":"Медиа","media tools":"Медиа-инструменты","documents":"Документы","compression":"Архивация","communication":"Связь","file sharing":"Обмен файлами","imaging":"Обработка изображений","gaming":"Игры","utilities":"Утилиты","disk tools":"Работа с дисками","development":"Разработка","security":"Безопасность","portable":"Портативные","runtimes":"Среды выполнения","drivers":"Драйверы","privacy":"Конфиденциальность","fixer":"Исправитель","performance":"Производительность","personalization":"Персонализация","power":"Мощность","protection":"Защита","classic":"Классический","auto":"Автоматический","package_manager":"Менеджер пакетов","DisablePopupText":"Показывать при обновлении"},"tr":{"name":"Türkçe","Welcome":"Birden fazla programı aynı anda yükleyerek zaman kazanın ve Windows performansınızı artırın. Bu aracı geliştirmek ve daha da iyileştirmek için bize katılın. Ayrıca favori müzik uygulamalarınızı ve ayarlarınızı da ekleyebilirsiniz.","Install":"Yükle","Apply":"Uygula","Downloading":"İndiriliyor...","About":"Hakkında","Third_party":"Üçüncü Taraf","Preferences":"Tercihler","Management":"Yönetim","Apps":"Uygulamalar","Tweaks":"İnce Ayarlar","Settings":"Ayarlar","Save":"Kayıt Et","Restore":"Geri Yükle","On":"Açık","Off":"Kapalı","Disk_Managment":"Disk Yönetimi","Msconfig":"Sistem Yapılandırması","Environment_Variables":"Ortam Değişkenleri","Task_Manager":"Görev Yöneticisi","Apps_features":"Uygulamalar-Özellikler","Networks":"Ağlar","Services":"Hizmetler","Device_Manager":"Aygıt Yöneticisi","Power_Options":"Güç Seçenekleri","System_Info":"Sistem Bilgisi","Use_system_setting":"Sistem ayarlarını kullan","Create_desktop_shortcut":"MASaüstü kısayolu oluştur","Reset_preferences":"Tercihleri sıfırla","Reopen_itt_again":"Lütfen ITT'yi tekrar açın.","Theme":"Tema","Language":"Dil","Browsers_extensions":"Tarayıcı Eklentileri","All":"Tümü","Search":"Ara","Create_restore_point":"Geri yükleme noktası oluştur","Portable_Downloads_Folder":"Taşınabilir İndirilenler Klasörü","Install_msg":"Aşağıdaki uygulamaları yüklemek istediğinizden emin misiniz?","Apply_msg":"Aşağıdaki ayarları uygulamak istediğinizden emin misiniz?","Applying":"Uygulanıyor...","Please_wait":"Lütfen bekleyin arka planda bir işlem çalışıyor","Last_update":"SOn güncelleme","Exit_msg":"Programı kapatmak istediğinizden emin misiniz? Herhangi bir kurulum varsa durdurulacak","Empty_save_msg":"Kaydetmek için en az bir uygulama seçin","easter_egg":"Gizli sırrı keşfedebilir misin? Kaynağa dal özelliği ilk keşfeden ol ve araca entegre et","system_protection":"Sistem koruması","web browsers":"Web Tarayıcıları","media":"Medya","media tools":"Medya Araçları","documents":"Belgeler","compression":"Sıkıştırma","communication":"İletişim","file sharing":"Dosya Paylaşımı","imaging":"Görüntü İşleme","gaming":"Oyun","utilities":"Araçlar","disk tools":"Disk Araçları","development":"Geliştirme","security":"Güvenlik","portable":"Taşınabilir","runtimes":"Çalışma Zamanı","drivers":"Sürücüler","privacy":"Gizlilik","fixer":"Düzeltici","performance":"Performans","personalization":"Kişiselleştirme","power":"Güç","protection":"Koruma","classic":"Klasik","auto":"otomatik","package_manager":"Paket Yöneticisi","DisablePopupText":"Güncellemede göster"},"zh":{"name":"中文","Welcome":"通过一次安装多个程序节省时间并提升您的Windows性能。加入我们，改进工具，使其更加优秀。","System_Info":"系统信息","Power_Options":"电源选项","Device_Manager":"设备管理器","Services":"服务","Networks":"网络","Apps_features":"应用特性","Task_Manager":"任务管理器","Disk_Managment":"磁盘管理","Msconfig":"系统配置","Environment_Variables":"环境变量","Install":"安装","Apply":"应用","Downloading":"下载中","About":"关于","Third_party":"第三方","Preferences":"偏好","Management":"管理","Apps":"应用","Tweaks":"调整","Settings":"设置","Save":"保存选定应用","Restore":"恢复选定应用","On":"开启","Off":"关闭","Reset_preferences":"重置偏好设置","Dark":"深色","Light":"浅色","Use_system_setting":"系统","Create_desktop_shortcut":"创建桌面快捷方式","Reopen_itt_again":"请重新打开ITT。","Theme":"主题","Language":"语言","Browsers_extensions":"浏览器扩展","All":"都","Create_restore_point":"创建还原点","Portable_Downloads_Folder":"便携下载文件夹","Install_msg":"是否要安装选定的应用","Apply_msg":"是否要应用选定的调整","instAlling":"安装中..","Applying":"应用中..","Please_wait":"请等待，后台有进程在进行中。","Last_update":"最后更新","Exit_msg":"您确定要关闭程序吗？如果有任何安装正在进行，它们将被终止。","easter_egg":"你能发现隐藏的秘密吗？深入源代码，成为第一个发现功能的人，并将其集成到工具中","system_protection":"系统保护","web browsers":"网页浏览器","media":"媒体","media tools":"媒体工具","documents":"文档","compression":"压缩","communication":"通讯","file sharing":"文件共享","imaging":"图像处理","gaming":"游戏","utilities":"实用工具","disk tools":"磁盘工具","development":"开发","security":"安全","portable":"便携版","runtimes":"运行时","drivers":"驱动程序","privacy":"隐私","fixer":"修复工具","performance":"性能","personalization":"个性化","power":"电力","protection":"保护","classic":"经典","auto":"自动","package_manager":"包管理器","DisablePopupText":"更新时显示"}}}
'@ | ConvertFrom-Json
function Invoke-Button {
Param ([string]$action,[string]$Content)
Switch -Wildcard ($action) {
"installBtn" {
$itt.SearchInput.Text = $null
Invoke-Install
}
"applyBtn" {
Invoke-Apply
}
"$($itt.CurrentCategory)" {
FilterByCat($itt["window"].FindName($itt.CurrentCategory).SelectedItem.Tag)
}
"searchInput" {
Search
}
"auto" {
Set-ItemProperty -Path $itt.registryPath -Name "source" -Value "auto" -Force
Set-Statusbar -Text "📢 Switched to auto"
}
"choco" {
Set-ItemProperty -Path $itt.registryPath -Name "source" -Value "choco" -Force
Set-Statusbar -Text "📢 Switched to choco"
}
"winget" {
Set-ItemProperty -Path $itt.registryPath -Name "source" -Value "winget" -Force
Set-Statusbar -Text "📢 Switched to winget"
}
"systemlang" {
Set-Language -lang "default"
}
"ar" {
Set-Language -lang "ar"
}
"de" {
Set-Language -lang "de"
}
"en" {
Set-Language -lang "en"
}
"es" {
Set-Language -lang "es"
}
"fr" {
Set-Language -lang "fr"
}
"hi" {
Set-Language -lang "hi"
}
"it" {
Set-Language -lang "it"
}
"ko" {
Set-Language -lang "ko"
}
"ru" {
Set-Language -lang "ru"
}
"tr" {
Set-Language -lang "tr"
}
"zh" {
Set-Language -lang "zh"
}
"save" {
Save-File
}
"load" {
Get-file
}
"deviceManager" {
Start-Process devmgmt.msc
}
"appsfeatures" {
Start-Process appwiz.cpl
}
"sysinfo" {
Start-Process msinfo32.exe
Start-Process dxdiag.exe
}
"poweroption" {
Start-Process powercfg.cpl
}
"services" {
Start-Process services.msc
}
"network" {
Start-Process ncpa.cpl
}
"taskmgr" {
Start-Process taskmgr.exe
}
"diskmgmt" {
Start-Process diskmgmt.msc
}
"msconfig" {
Start-Process msconfig.exe
}
"ev" {
rundll32 sysdm.cpl,EditEnvironmentVariables
}
"spp" {
systemPropertiesProtection
}
"systheme" {
SwitchToSystem
}
"Dark" {
Set-Theme -Theme $action
}
"DarkKnight" {
Set-Theme -Theme $action
}
"Light" {
Set-Theme -Theme $action
}
"Palestine" {
Set-Theme -Theme $action
}
"chocoloc" {
Start-Process explorer.exe "C:\ProgramData\chocolatey\lib"
}
"itt" {
Start-Process explorer.exe $env:ProgramData\itt
}
"restorepoint" {
ITT-ScriptBlock -ScriptBlock{CreateRestorePoint}
}
"unhook" {
Start-Process "https://unhook.app/"
}
"efy" {
Start-Process "https://www.mrfdev.com/enhancer-for-youtube"
}
"uBlock" {
Start-Process "https://ublockorigin.com/"
}
"mas" {
Add-Log -Message "Microsoft Activation Scripts (MAS)" -Level "info"
ITT-ScriptBlock -ScriptBlock {irm https://get.activated.win | iex}
}
"idm" {
Add-Log -Message "Running IDM Activation..." -Level "info"
ITT-ScriptBlock -ScriptBlock {curl.exe -L -o $env:TEMP\\IDM_Trial_Reset.exe "https://github.com/itt-co/itt-packages/raw/refs/heads/main/automation/idm-trial-reset/IDM%20Trial%20Reset.exe"; cmd /c "$env:TEMP\\IDM_Trial_Reset.exe"}
}
"winoffice" {
Start-Process "https://linkjust.com/massgrave"
}
"sordum" {
Start-Process "https://linkjust.com/sordum"
}
"majorgeeks" {
Start-Process "https://www.majorgeeks.com/"
}
"techpowerup" {
Start-Process "https://www.techpowerup.com/download/"
}
"ittshortcut" {
ITTShortcut $action
}
"dev" {
About
}
"shelltube"{
Start-Process -FilePath "powershell" -ArgumentList "irm https://github.com/emadadel4/shelltube/releases/latest/download/st.ps1 | iex"
}
"rapidos"{
Start-Process ("https://github.com/rapid-community/RapidOS")
}
"asustool"{
Start-Process ("https://github.com/codecrafting-io/asus-setup-tool")
}
"webtor"{
Start-Process ("https://webtor.io/")
}
"spotifydown"{
Start-Process ("https://spotidownloader.com/")
}
"finddriver"{
Find-Driver
}
"taps"{
ChangeTap
}
"github"{
Start-Process("https://github.com/emadadeldev/ittea")
}
"community"{
Start-Process("https://t.me/+qnB0HvMH4ocxZDc8")
}
"translate"{
Start-Process("https://github.com/emadadeldev/ittea/tree/main/locales")
}
"donate"{
Start-Process("https://github.com/emadadeldev/ittea/blob/main/.github/DONATE.md")
}
}
}
function ITT-ScriptBlock {
param(
[scriptblock]$ScriptBlock,
[array]$ArgumentList,
$Debug
)
$script:powershell = [powershell]::Create()
$script:powershell.AddScript($ScriptBlock)
$script:powershell.AddArgument($ArgumentList)
$script:powershell.AddArgument($Debug)
$script:powershell.RunspacePool = $itt.runspace
$script:handle = $script:powershell.BeginInvoke()
if ($script:handle.IsCompleted) {
$script:powershell.EndInvoke($script:handle)
$script:powershell.Dispose()
$itt.runspace.Dispose()
$itt.runspace.Close()
[System.GC]::Collect()
}
return $handle
}
function CreateRestorePoint {
try {
Set-Statusbar -Text "✋ Please wait Creating a restore point..."
Add-Log "Creating restore point..." "info"
Set-ItemProperty "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\SystemRestore" "SystemRestorePointCreationFrequency" 0 -Type DWord -Force
powershell.exe -NoProfile -Command {
Enable-ComputerRestore -Drive $env:SystemDrive
Checkpoint-Computer -Description ("ITT-" + (Get-Date -Format "yyyyMMdd-hhmmss-tt")) -RestorePointType "MODIFY_SETTINGS"
}
Set-ItemProperty $itt.registryPath "backup" 1 -Force
Set-Statusbar -Text "✔ Created successfully. Applying tweaks..."
Add-Log "Created successfully. Applying tweaks..." "info"
} catch {
Add-Log "Error: $_" "ERROR"
}
}
function Add-Log {
param ([string]$Message, [string]$Level = "Default")
$level = $Level.ToUpper()
$colorMap = @{ INFO="White"; WARNING="Yellow"; ERROR="Red"; INSTALLED="White"; APPLY="White"; DEBUG="Yellow" }
$iconMap  = @{ INFO="[i]"; WARNING="[!]"; ERROR="[X]"; DEFAULT=""; DEBUG="[DEBUG]"; ITT="[ITT]"; Chocolatey="[Chocolatey]"; Winget="[Winget]" }
$color = if ($colorMap.ContainsKey($level)) { $colorMap[$level] } else { "White" }
$icon  = if ($iconMap.ContainsKey($level)) { $iconMap[$level] } else { "i" }
Write-Host "$icon $Message" -ForegroundColor $color
}
function ExecuteCommand {
param ($tweak)
try {
Add-Log -Message "Please wait..."
$script = [scriptblock]::Create($tweak)
Invoke-Command  $script -ErrorAction Stop
} catch  {
Add-Log -Message "The specified command was not found." -Level "WARNING"
}
}
function Finish {
param (
[string]$ListView,
[string]$title = "ITT Emad Adel",
[string]$icon = "Info"
)
switch ($ListView) {
"AppsListView" {
UpdateUI -Button "InstallBtn" -Content "Install" -Width "140"
Notify -title "$title" -msg "All installations have finished" -icon "Info" -time 30000
Add-Log -Message "`n::::All installations have finished::::"
Set-Statusbar -Text "📢 All installations have finished"
}
"TweaksListView" {
UpdateUI -Button "ApplyBtn" -Content "Apply" -Width "140"
Add-Log -Message "`n::::All tweaks have finished::::"
Set-Statusbar -Text "📢 All tweaks have finished"
Notify -title "$title" -msg "All tweaks have finished" -icon "Info" -time 30000
}
}
$itt["window"].Dispatcher.Invoke([action] { Set-Taskbar -progress "None" -value 0.01 -icon "logo" })
$itt.$ListView.Dispatcher.Invoke([Action] {
foreach ($item in $itt.$ListView.Items) {$item.IsChecked = $false}
$collectionView = [System.Windows.Data.CollectionViewSource]::GetDefaultView($itt.$ListView.Items)
$collectionView.Filter = $null
$collectionView.Refresh()
})
}
function Get-SelectedItems {
param ([ValidateSet("AppsListView","TweaksListView")] [string]$Mode)
$listView = if ($Mode -eq "AppsListView") { $itt.AppsListView } else { $itt.TweaksListView }
$props    = if ($Mode -eq "AppsListView") { 'Content','Choco','Scoop','Winget','ITT' } else { 'Name','Script' }
$selected = foreach ($item in $listView.Items) {
if ($item.IsChecked) {
$obj = @{}
foreach ($p in $props) { $obj[$p] = $item.$p }
$obj
}
}
return $selected
}
function Show-Selected {
param ([string]$ListView, [string]$Mode)
$view = [System.Windows.Data.CollectionViewSource]::GetDefaultView($itt.$ListView.Items)
if ($Mode -eq 'Filter') {
$view.Filter = { param($i) $i.IsChecked }
}
else {
foreach ($i in $itt.$ListView.Items) { $i.IsChecked = $false }
$view.Filter = $null
}
}
function Get-ToggleStatus {
Param($ToggleSwitch)
if ($ToggleSwitch -eq "darkmode") {
$app = (Get-ItemProperty -path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize').AppsUseLightTheme
$system = (Get-ItemProperty -path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize').SystemUsesLightTheme
if ($app -eq 0 -and $system -eq 0) {
return $true
}
else {
return $false
}
}
if ($ToggleSwitch -eq "showfileextensions") {
$hideextvalue = (Get-ItemProperty -path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced').HideFileExt
if ($hideextvalue -eq 0) {
return $true
}
else {
return $false
}
}
if ($ToggleSwitch -eq "showsuperhidden") {
$hideextvalue = (Get-ItemPropertyValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSuperHidden")
if ($hideextvalue -eq 1) {
return $true
}
else {
return $false
}
}
if ($ToggleSwitch -eq "numlook") {
$numlockvalue = (Get-ItemProperty -path 'HKCU:\Control Panel\Keyboard').InitialKeyboardIndicators
if ($numlockvalue -eq 2) {
return $true
}
else {
return $false
}
}
if ($ToggleSwitch -eq "stickykeys") {
$StickyKeys = (Get-ItemProperty -path 'HKCU:\Control Panel\Accessibility\StickyKeys').Flags
if ($StickyKeys -eq 58) {
return $false
}
else {
return $true
}
}
if ($ToggleSwitch -eq "mouseacceleration") {
$Speed = (Get-ItemProperty -path 'HKCU:\Control Panel\Mouse').MouseSpeed
$Threshold1 = (Get-ItemProperty -path 'HKCU:\Control Panel\Mouse').MouseThreshold1
$Threshold2 = (Get-ItemProperty -path 'HKCU:\Control Panel\Mouse').MouseThreshold2
if ($Speed -eq 1 -and $Threshold1 -eq 6 -and $Threshold2 -eq 10) {
return $true
}
else {
return $false
}
}
if ($ToggleSwitch -eq "endtaskontaskbarwindows11") {
$path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\TaskbarDeveloperSettings"
if (-not (Test-Path $path)) {
return $false
}
else {
$TaskBar = (Get-ItemProperty -path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\TaskbarDeveloperSettings').TaskbarEndTask
if ($TaskBar -eq 1) {
return $true
}
else {
return $false
}
}
}
if ($ToggleSwitch -eq "clearpagefileatshutdown") {
$PageFile = (Get-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\\Memory Management').ClearPageFileAtShutdown
if ($PageFile -eq 1) {
return $true
}
else {
return $false
}
}
if ($ToggleSwitch -eq "autoendtasks") {
$PageFile = (Get-ItemProperty -path 'HKCU:\Control Panel\Desktop').AutoEndTasks
if ($PageFile -eq 1) {
return $true
}
else {
return $false
}
}
if ($ToggleSwitch -eq "performanceoptions") {
$VisualFXSetting = (Get-ItemProperty -path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects').VisualFXSetting
if ($VisualFXSetting -eq 2) {
return $true
}
else {
return $false
}
}
if ($ToggleSwitch -eq "launchtothispc") {
$LaunchTo = (Get-ItemProperty -path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced').LaunchTo
if ($LaunchTo -eq 1) {
return $true
}
else {
return $false
}
}
if ($ToggleSwitch -eq "disableautomaticdriverinstallation") {
$disableautomaticdrive = (Get-ItemProperty -path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching').SearchOrderConfig
if ($disableautomaticdrive -eq 1) {
return $true
}
else {
return $false
}
}
if ($ToggleSwitch -eq "AlwaysshowiconsneverThumbnail") {
$alwaysshowicons = (Get-ItemProperty -path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced').IconsOnly
if ($alwaysshowicons -eq 1) {
return $true
}
else {
return $false
}
}
if ($ToggleSwitch -eq "CoreIsolationMemoryIntegrity") {
try {
$CoreIsolationMemory = (Get-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\CredentialGuard').Enabled
if ($CoreIsolationMemory -eq 1) {
return $true
}
else {
return $false
}
}
catch {
return $false
}
}
if ($ToggleSwitch -eq "WindowsSandbox") {
$WS = Get-WindowsOptionalFeature -Online -FeatureName "Containers-DisposableClientVM"
if ($WS.State -eq "Enabled") {
return $true
}
else {
return $false
}
}
if ($ToggleSwitch -eq "WindowsSubsystemforLinux") {
$WSL = Get-WindowsOptionalFeature -Online -FeatureName "Microsoft-Windows-Subsystem-Linux"
if ($WSL.State -eq "Enabled") {
return $true
}
else {
return $false
}
}
if ($ToggleSwitch -eq "HyperVVirtualization") {
$HyperV = Get-WindowsOptionalFeature -Online -FeatureName "Microsoft-Hyper-V"
if ($HyperV.State -eq "Enabled") {
return $true
}
else {
return $false
}
}
if ($ToggleSwitch -eq "EnableAutoTray") {
$EnableAutoTray = (Get-ItemProperty -path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer').EnableAutoTray
if ($EnableAutoTray -eq 0) {
return $true
}
else {
return $false
}
}
}
function Install-App {
param ([string]$Source, [string]$Name,[string]$Choco,[string]$Scoop,[string]$Winget,[string]$ITT)
$wingetArgs = "install --id $Winget --silent --accept-source-agreements --accept-package-agreements --force"
$chocoArgs = "install $Choco --confirm --acceptlicense -q --ignore-http-cache --limit-output --allowemptychecksumsecure --ignorechecksum --allowemptychecksum --usepackagecodes --ignoredetectedreboot --ignore-checksums --ignore-reboot-requests"
$ittArgs = "install $ITT -y"
$scoopArgs = "$Scoop"
function Install-AppWithInstaller {
param ([string]$Installer,[string]$InstallArgs)
$process = Start-Process -FilePath $Installer -ArgumentList $InstallArgs -NoNewWindow -Wait -PassThru
return $process.ExitCode
}
function Log {
param ([string]$Installer,[string]$Source)
if ($Installer -ne 0) {
return @{ Success = $false; Message = "Installation Failed for ($Name). Report the issue in ITT repository." }
}
else {
return @{ Success = $true; Message = "Successfully Installed ($Name)" }
}
}
if ($Source -ne "auto") {
switch ($Source.ToLower()) {
"choco" {
if ($Choco -eq "na") {
Add-Log -Message "Chocolatey package not available for $Name" -Level "WARNING"
return @{ Success = $false; Message = "This app is not available in Chocolatey" }
}
Install-Dependencies -PKGMan "choco"
$exitCode = Install-AppWithInstaller "choco" $chocoArgs
return Log $exitCode "Chocolatey"
}
"winget" {
if ($Winget -eq "na") {
Add-Log -Message "Winget package not available for $Name" -Level "WARNING"
return @{ Success = $false; Message = "This app is not available in Winget" }
}
Install-Dependencies -PKGMan "winget"
$exitCode = Install-AppWithInstaller "winget" $wingetArgs
return Log $exitCode "Winget"
}
"scoop" {
if ($Scoop -eq "na") {
Add-Log -Message "Scoop package not available for $Name" -Level "WARNING"
return @{ Success = $false; Message = "This app is not available in Scoop" }
}
Install-Dependencies -PKGMan "scoop"
$LASTEXITCODE = scoop install $scoopArgs
return Log $LASTEXITCODE "Scoop"
}
default {
Add-Log -Message "Invalid package manager specified: $Source" -Level "ERROR"
return @{ Success = $false; Message = "Invalid package manager" }
}
}
}
if ($Choco -eq "na" -and $Winget -eq "na" -and $itt -ne "na") {
Install-Dependencies -PKGMan "itt"
Add-Log -Message "Attempting to install $Name." -Level "ITT"
$ITTResult = Install-AppWithInstaller "itt" $ittArgs
Log $ITTResult "itt"
}
else
{
if ($Choco -eq "na" -and $Scoop -eq "na" -and $Winget -ne "na")
{
Add-Log -Message "Attempting to install $Name." -Level "Winget"
Install-Dependencies -PKGMan "winget"
Start-Process -FilePath "winget" -ArgumentList "settings --enable InstallerHashOverride" -NoNewWindow -Wait -PassThru
$wingetResult = Install-AppWithInstaller "winget" $wingetArgs
Log $wingetResult "Winget"
}
else
{
if ($Choco -ne "na" -or $Winget -ne "na" -or $Scoop -ne "na")
{
Add-Log -Message "Attempting to install $Name." -Level "Chocolatey"
Install-Dependencies -PKGMan "choco"
$chocoResult = Install-AppWithInstaller "choco" $chocoArgs
if ($chocoResult -ne 0) {
Add-Log -Message "installation failed, Falling back to winget." -Level "info"
Install-Dependencies -PKGMan "winget"
$wingetResult = Install-AppWithInstaller "winget" $wingetArgs
if ($wingetResult -ne 0) {
Add-Log -Message "installation failed, Falling back to scoop." -Level "info"
Install-Dependencies -PKGMan "scoop"
scoop install $scoopArgs
Log $LASTEXITCODE "Scoop"
}else {
Log $wingetResult "Winget"
}
}
else
{
Log $chocoResult "Chocolatey"
}
}
else
{
Add-Log -Message "$Name is not available in any package manager" -Level "info"
}
}
}
}
function Install-Dependencies {
param ([string]$PKGMan)
switch ($PKGMan)
{
"itt" {
if (-not (Get-Command itt -ErrorAction SilentlyContinue))
{
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/itt-co/bin/refs/heads/main/install.ps1')) *> $null
}
else
{
try {
$currentVersion = (itt.exe -ver)
$installerPath = "$env:TEMP\installer.msi"
$latestReleaseApi = "https://api.github.com/repos/itt-co/bin/releases/latest"
$latestVersion = (Invoke-RestMethod -Uri $latestReleaseApi).tag_name
if ($latestVersion -eq $currentVersion) {return}
Invoke-WebRequest "https://github.com/itt-co/bin/releases/latest/download/installer.msi" -OutFile $installerPath
Start-Process msiexec.exe -ArgumentList "/i `"$installerPath`" /q" -NoNewWindow -Wait
Write-Host "Updated to version $latestVersion successfully."
}
catch {
Add-Log -Message "$_" -Level "error"
}
}
}
"choco" {
if (-not (Get-Command choco -ErrorAction SilentlyContinue))
{
Add-Log -Message "Installing dependencies..." -Level "INFO"
Add-Log -Message "This might take few seconds" -Level "INFO"
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1')) *> $null
}
}
"winget" {
if(Get-Command winget -ErrorAction SilentlyContinue) {return}
$ComputerInfo = Get-ComputerInfo -ErrorAction Stop
$arch = [int](($ComputerInfo).OsArchitecture -replace '\D', '')
if ($ComputerInfo.WindowsVersion -lt "1809") {
Add-Log -Message "Winget is not supported on this version of Windows Upgrade to 1809 or newer." -Level "info"
return
}
$VCLibs = "https://aka.ms/Microsoft.VCLibs.x$arch.14.00.Desktop.appx"
$UIXaml = "https://github.com/microsoft/microsoft-ui-xaml/releases/download/v2.8.6/Microsoft.UI.Xaml.2.8.x$arch.appx"
$WingetLatset = "https://aka.ms/getwinget"
try {
Add-Log -Message "Installing Winget..." -Level "info"
Add-Log -Message "This might take several minutes" -Level "info"
Start-BitsTransfer -Source $VCLibs -Destination "$env:TEMP\Microsoft.VCLibs.Desktop.appx"
Start-BitsTransfer -Source $UIXaml -Destination "$env:TEMP\Microsoft.UI.Xaml.appx"
Start-BitsTransfer -Source $WingetLatset -Destination "$env:TEMP\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
Add-AppxPackage "$env:TEMP\Microsoft.VCLibs.Desktop.appx"
Add-AppxPackage "$env:TEMP\Microsoft.UI.Xaml.appx"
Add-AppxPackage "$env:TEMP\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
Start-Sleep -Seconds 1
Add-Log -Message "Successfully installed Winget. Continuing to install selected apps..." -Level "info"
return
}
catch {
Write-Error "Failed to install $_"
}
}
"scoop" {
if (-not (Get-Command scoop -ErrorAction SilentlyContinue))
{
Add-Log -Message "Installing scoop..." -Level "info"
Add-Log -Message "This might take few seconds" -Level "info"
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
Invoke-WebRequest -useb get.scoop.sh | Invoke-Expression
scoop bucket add extras
}
}
}
}
function Refresh-Explorer {
Add-Log -Message "Restart explorer." -Level "info"
Stop-Process -processName: Explorer -Force
Start-Sleep -Seconds 1
if (-not (Get-Process -processName: Explorer)) {
Start-Process explorer.exe
}
}
function Get-file {
if ($itt.ProcessRunning) {
Message -key "Please_wait" -icon "Warning" -action "OK"
return
}
$openFileDialog = New-Object Microsoft.Win32.OpenFileDialog -Property @{
Filter = "itt files (*.itt)|*.itt"
Title  = "itt File"
}
if ($openFileDialog.ShowDialog() -eq $true) {
try {
$FileContent = Get-Content -Path $openFileDialog.FileName -Raw | ConvertFrom-Json -ErrorAction Stop
if ($FileContent.ListView -ne $itt.currentList) {
Message -NoneKey "PLEASE SELECT THE CORRECT TAB" -icon "Warning" -action "OK"
return
}
$collectionView = [System.Windows.Data.CollectionViewSource]::GetDefaultView($itt.($itt.currentList).Items)
$collectionView.Filter = {
param($item)
if ($FileContent.Items.Name -contains $item.Content) {
$item.IsChecked = $true
return $true
} else {
return $false
}
}
}
catch {
Write-Warning "Failed to load or parse JSON file: $_"
}
}
}
function Save-File {
$itt['window'].FindName($itt.currentList).SelectedIndex = 0
Show-Selected -ListView "$($itt.currentList)" -Mode "Filter"
$selectedApps = Get-SelectedItems -Mode "$($itt.currentList)"
if ($selectedApps.Count -le 0) { return }
$items = foreach ($item in $itt.$($itt.currentList).Items) {
if ($item.IsChecked) {
[PSCustomObject]@{
Name = $item.Content
}
}
}
if ($items.Count -eq 0) {
Message -key "Empty_save_msg" -icon "Information" -action "OK"
return
}
$jsonObject = @{
ListView = $itt.currentList
Items    = $items
}
$saveFileDialog = New-Object Microsoft.Win32.SaveFileDialog -Property @{
Filter = "JSON files (*.itt)|*.itt"
Title  = "Save JSON File"
}
if ($saveFileDialog.ShowDialog() -eq $true) {
$jsonObject | ConvertTo-Json -Compress | Out-File -FilePath $saveFileDialog.FileName -Force
Write-Host "Saved: $($saveFileDialog.FileName)"
}
Show-Selected -ListView "$($itt.currentList)" -Mode "Default"
}
function Set-Taskbar {
param ([string]$progress,[double]$value,[string]$icon)
try {
if ($value) {
$itt["window"].taskbarItemInfo.ProgressValue = $value
}
if($progress)
{
switch ($progress) {
'None' { $itt["window"].taskbarItemInfo.ProgressState = "None" }
'Normal' { $itt["window"].taskbarItemInfo.ProgressState = "Normal" }
'Indeterminate' { $itt["window"].taskbarItemInfo.ProgressState = "Indeterminate" }
'Error' { $itt["window"].taskbarItemInfo.ProgressState = "Error" }
default { throw "Set-Taskbar Invalid state" }
}
}
if($icon)
{
switch ($icon) {
"done" {$itt["window"].taskbarItemInfo.Overlay = "https://raw.githubusercontent.com/emadadel4/ITT/main/static/Icons/done.png"}
"logo" {$itt["window"].taskbarItemInfo.Overlay = "https://raw.githubusercontent.com/emadadel4/ITT/main/static/Icons/icon.ico"}
"error" {$itt["window"].taskbarItemInfo.Overlay = "https://raw.githubusercontent.com/emadadel4/IT/main/static/Icons/error.png"}
default{$itt["window"].taskbarItemInfo.Overlay = "https://raw.githubusercontent.com/emadadel4/main//static/Icons/icon.ico"}
}
}
}
catch {
}
}
function Startup {
ITT-ScriptBlock -ArgumentList $Debug -ScriptBlock {
param($Debug)
function UsageCount {
try {
$Message = "👨‍💻 Build Ver: $($itt.lastupdate)`n🚀 URL: $($itt.command)"
$EncodedMessage = [uri]::EscapeDataString($Message)
$Url = "itt.emadadel4-a0a.workers.dev/log?text=$EncodedMessage"
$result = Invoke-RestMethod -Uri $Url -Method GET
Add-Log -Message "`n  $result times worldwide`n"
}
catch {
Add-Log -Message "Unstable internet connection detected." -Level "info"
Start-Sleep 8
UsageCount
}
}
function Quotes {
$q=(Invoke-RestMethod "https://raw.githubusercontent.com/emadadel4/itt/refs/heads/main/static/Database/Quotes.json").Quotes|Sort-Object {Get-Random}
Set-Statusbar -Text "☕ $($itt.database.locales.Controls.$($itt.Language).welcome)"; Start-Sleep 18
Set-Statusbar -Text "👁‍🗨 $($itt.database.locales.Controls.$($itt.Language).easter_egg)"; Start-Sleep 18
$i=@{quote="💬";info="📢";music="🎵";Cautton="⚠";default="☕"}
while(1){foreach($x in $q){$c=$i[$x.type];if(-not $c){$c=$i.default};$t="`“$($x.text)`”";if($x.name){$t+=" ― $($x.name)"};Set-Statusbar -Text "$c $t";Start-Sleep 25}}
}
function LOG {
Write-Host "  `n` "
Write-Host "  ███████████████████╗ My old GitHub account was restricted without any reason from GitHub support"
Write-Host "  ██╚══██╔══╚═══██╔══╝ This is the new repository, please share it so people can easily"
Write-Host "  ██║  ██║ Emad ██║    offical repo: https://github.com/emadadeldev/ittea"
Write-Host "  ██║  ██║ Adel ██║    Backup:https: //gitlab.com/emadadel/itt/"
Write-Host "  ██║  ██║      ██║    "
Write-Host "  ╚═╝  ╚═╝      ╚═╝    "
UsageCount
}
LOG
Quotes
}
}
function ChangeTap {
$tabSettings = @{
'apps'        = @{
'installBtn' = 'Visible';
'applyBtn' = 'Hidden';
'CurrentList' = 'AppsListView';
'searchInput' = 'Visible';
'CurrentCategory' = 'AppsCategory'
}
'tweeksTab'   = @{
'installBtn' = 'Hidden';
'applyBtn' = 'Visible';
'CurrentList' = 'TweaksListView';
'searchInput' = 'Visible';
'CurrentCategory' = 'TwaeksCategory'
}
'SettingsTab' = @{
'installBtn' = 'Hidden';
'applyBtn' = 'Hidden';
'searchInput' = 'Collapsed';
'CurrentList' = 'SettingsList'
}
'WhatsNewTab' = @{
'installBtn' = 'Hidden';
'applyBtn' = 'Hidden';
'searchInput' = 'Collapsed';
'hotdot' =  [System.Windows.Visibility]::Hidden;
}
}
foreach ($tab in $tabSettings.Keys) {
if ($itt['window'].FindName($tab).IsSelected) {
$settings = $tabSettings[$tab]
$itt.CurrentList = $settings['CurrentList']
$itt.CurrentCategory = $settings['CurrentCategory']
$itt['window'].FindName('installBtn').Visibility = $settings['installBtn']
$itt['window'].FindName('applyBtn').Visibility = $settings['applyBtn']
$itt['window'].FindName('AppsCategory').Visibility = $settings['installBtn']
$itt['window'].FindName('TwaeksCategory').Visibility = $settings['applyBtn']
$itt['window'].FindName('searchInput').Visibility = $settings['searchInput']
if ($settings.ContainsKey('hotdot') -and $itt['window'].FindName('hotdot')) {
$itt['window'].FindName('hotdot').Visibility = $settings['hotdot']
}
break
}
}
}
function Invoke-Apply {
if ($itt.ProcessRunning) {
Message -key "Please_wait" -icon "Warning" -action "OK"
return
}
$itt['window'].FindName("TwaeksCategory").SelectedIndex = 0
$selectedTweaks = Get-SelectedItems -Mode "TweaksListView"
if ($selectedTweaks.Count -le 0) {return}
Show-Selected -ListView "TweaksListView" -Mode "Filter"
$result = Message -key "Apply_msg" -icon "ask" -action "YesNo"
if ($result -eq "no") {
Show-Selected -ListView "TweaksListView" -Mode "Default"
return
}
ITT-ScriptBlock -ArgumentList $selectedTweaks -debug $debug -ScriptBlock {
param($selectedTweaks, $debug)
$itt.ProcessRunning = $true
if((Get-ItemProperty -Path $itt.registryPath -Name "backup" -ErrorAction Stop).backup -eq 0){
UpdateUI -Button "ApplyBtn" -NonKey "Please Wait..." -Width "auto"
Set-Statusbar -Text "ℹ Current task: Creating Restore Point..."
CreateRestorePoint
}
UpdateUI -Button "ApplyBtn" -Content "Applying" -Width "auto"
$itt["window"].Dispatcher.Invoke([action] { Set-Taskbar -progress "Indeterminate" -value 0.01 -icon "logo" })
foreach ($tweak in $selectedTweaks) {
Add-Log -Message "::::$($tweak.Content)::::" -Level "default"
ExecuteCommand -tweak $tweak.Script
}
$itt.ProcessRunning = $false
Finish -ListView "TweaksListView"
}
}
function Invoke-Install {
if ($itt.ProcessRunning) {
Message -key "Please_wait" -icon "Warning" -action "OK"
return
}
$itt['window'].FindName("AppsCategory").SelectedIndex = 0
$selectedApps = Get-SelectedItems -Mode "AppsListView"
if ($selectedApps.Count -le 0) {return}
Show-Selected -ListView "AppsListView" -Mode "Filter"
if (-not $i) {
$result = Message -key "Install_msg" -icon "ask" -action "YesNo"
}
if ($result -eq "no") {
Show-Selected -ListView "AppsListView" -Mode "Default"
return
}
$itt.PackgeManager = (Get-ItemProperty -Path $itt.registryPath -Name "source" -ErrorAction Stop).source
ITT-ScriptBlock -ArgumentList $selectedApps $i $source -Debug $debug -ScriptBlock {
param($selectedApps , $i, $source)
UpdateUI -Button "installBtn" -Content "Downloading" -Width "auto"
$itt["window"].Dispatcher.Invoke([action] { Set-Taskbar -progress "Indeterminate" -value 0.01 -icon "logo" })
$itt.ProcessRunning = $true
foreach ($App in $selectedApps) {
Write-Host $source
Set-Statusbar -Text "ℹ Current task: Downloading $($App.Content)"
$chocoFolder = Join-Path $env:ProgramData "chocolatey\lib\$($App.Choco)"
$ITTFolder = Join-Path $env:ProgramData "itt\downloads\$($App.ITT)"
Remove-Item -Path "$chocoFolder" -Recurse -Force
Remove-Item -Path "$chocoFolder.install" -Recurse -Force
Remove-Item -Path "$env:TEMP\chocolatey" -Recurse -Force
Remove-Item -Path "$ITTFolder" -Recurse -Force
$Install_result = Install-App -Source $itt.PackgeManager -Name $App.Content -Choco $App.Choco -Scoop $App.Scoop -Winget $App.Winget -itt $App.ITT
if ($Install_result.Success) {
Set-Statusbar -Text "✔ $($Install_result.Message)"
Add-Log -Message "$($Install_result.Message)" -Level "info"
} else {
Set-Statusbar -Text "✖ $($Install_result.Message)"
Add-Log -Message "$($Install_result.Message)" -Level "ERROR"
}
}
Finish -ListView "AppsListView"
$itt.ProcessRunning = $false
}
}
function Invoke-Toggle {
Param ([string]$debug)
Switch -Wildcard ($debug) {
"showfileextensions" { Invoke-ShowFile-Extensions $(Get-ToggleStatus showfileextensions) }
"darkmode" { Invoke-DarkMode $(Get-ToggleStatus darkmode) }
"showsuperhidden" { Invoke-ShowFile $(Get-ToggleStatus showsuperhidden) }
"numlook" { Invoke-NumLock $(Get-ToggleStatus numlook) }
"stickykeys" { Invoke-StickyKeys $(Get-ToggleStatus stickykeys) }
"mouseacceleration" { Invoke-MouseAcceleration $(Get-ToggleStatus mouseacceleration) }
"endtaskontaskbarwindows11" { Invoke-TaskbarEnd $(Get-ToggleStatus endtaskontaskbarwindows11) }
"clearpagefileatshutdown" { Invoke-ClearPageFile $(Get-ToggleStatus clearpagefileatshutdown) }
"autoendtasks" { Invoke-AutoEndTasks $(Get-ToggleStatus autoendtasks) }
"performanceoptions" { Invoke-PerformanceOptions $(Get-ToggleStatus performanceoptions) }
"launchtothispc" { Invoke-LaunchTo $(Get-ToggleStatus launchtothispc) }
"disableautomaticdriverinstallation" { Invoke-DisableAutoDrivers $(Get-ToggleStatus disableautomaticdriverinstallation) }
"AlwaysshowiconsneverThumbnail" { Invoke-ShowFile-Icons $(Get-ToggleStatus AlwaysshowiconsneverThumbnail) }
"CoreIsolationMemoryIntegrity" { Invoke-Core-Isolation $(Get-ToggleStatus CoreIsolationMemoryIntegrity) }
"WindowsSandbox" { Invoke-WindowsSandbox $(Get-ToggleStatus WindowsSandbox) }
"WindowsSubsystemforLinux" { Invoke-WindowsSandbox $(Get-ToggleStatus WindowsSubsystemforLinux) }
"HyperVVirtualization" { Invoke-HyperV $(Get-ToggleStatus HyperVVirtualization) }
"EnableAutoTray" { Invoke-EnableAutoTray $(Get-ToggleStatus EnableAutoTray) }
}
}
function Invoke-AutoEndTasks {
Param(
$Enabled,
[string]$Path = "HKCU:\Control Panel\Desktop",
[string]$name = "AutoEndTasks"
)
Try{
if ($Enabled -eq $false){
$value = 1
Add-Log -Message "Enabled auto end tasks" -Level "info"
}
else {
$value = 0
Add-Log -Message "Disabled auto end tasks" -Level "info"
}
Set-ItemProperty -Path $Path -Name $name -Value $value -ErrorAction Stop
}
Catch [System.Security.SecurityException] {
Write-Warning "Unable to set $Path\$Name to $Value due to a Security Exception"
}
Catch [System.Management.Automation.ItemNotFoundException] {
Write-Warning $psitem.Exception.ErrorRecord
}
Catch{
Write-Warning "Unable to set $Name due to unhandled exception"
Write-Warning $psitem.Exception.StackTrace
}
}
function Invoke-LaunchTo {
Param(
$Enabled,
[string]$Path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced",
[string]$name = "LaunchTo"
)
Try{
if ($Enabled -eq $false){
$value = 1
Add-Log -Message "Launch to This PC" -Level "info"
}
else {
$value = 2
Add-Log -Message "Launch to Quick Access" -Level "info"
}
Set-ItemProperty -Path $Path -Name $name -Value $value -ErrorAction Stop
Refresh-Explorer
}
Catch [System.Security.SecurityException] {
Write-Warning "Unable to set $Path\$Name to $Value due to a Security Exception"
}
Catch [System.Management.Automation.ItemNotFoundException] {
Write-Warning $psitem.Exception.ErrorRecord
}
Catch{
Write-Warning "Unable to set $Name due to unhandled exception"
Write-Warning $psitem.Exception.StackTrace
}
}
function Invoke-ClearPageFile {
Param(
$Enabled,
[string]$Path = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\\Memory Management",
[string]$name = "ClearPageFileAtShutdown"
)
Try {
if ($Enabled -eq $false) {
$value = 1
Add-Log -Message "Show End Task on taskbar" -Level "info"
}
else {
$value = 0
Add-Log -Message "Disable End Task on taskbar" -Level "info"
}
Set-ItemProperty -Path $Path -Name $name -Value $value -ErrorAction Stop
}
Catch [System.Security.SecurityException] {
Write-Warning "Unable to set $Path\$Name to $Value due to a Security Exception"
}
Catch [System.Management.Automation.ItemNotFoundException] {
Write-Warning $psitem.Exception.ErrorRecord
}
Catch {
Write-Warning "Unable to set $Name due to unhandled exception"
Write-Warning $psitem.Exception.StackTrace
}
}
function Invoke-Core-Isolation {
param ($Enabled, $Name = "Enabled", $Path = "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\CredentialGuard")
Try {
if ($Enabled -eq $false) {
$value = 1
Add-Log -Message "This change require a restart" -Level "info"
}
else {
$value = 0
Add-Log -Message "This change require a restart" -Level "info"
}
Set-ItemProperty -Path $Path -Name $Name -Value $value -ErrorAction Stop
Refresh-Explorer
}
Catch [System.Security.SecurityException] {
Write-Warning "Unable to set $Path\$Name to $Value due to a Security Exception"
}
Catch [System.Management.Automation.ItemNotFoundException] {
Write-Warning $psitem.Exception.ErrorRecord
}
Catch {
Write-Warning "Unable to set $Name due to unhandled exception"
Write-Warning $psitem.Exception.StackTrace
}
}
function Invoke-DarkMode {
Param($DarkMoveEnabled)
Try{
$Theme = (Get-ItemProperty -Path $itt.registryPath -Name "Theme").Theme
if ($DarkMoveEnabled -eq $false){
$DarkMoveValue = 0
Add-Log -Message "Dark Mode" -Level "info"
if($Theme -eq "default")
{
$itt['window'].Resources.MergedDictionaries.Add($itt['window'].FindResource("Dark"))
$itt.Theme = "Dark"
}
}
else {
$DarkMoveValue = 1
Add-Log -Message "Light Mode" -Level "info"
if($Theme -eq "default")
{
$itt['window'].Resources.MergedDictionaries.Add($itt['window'].FindResource("Light"))
$itt.Theme = "Light"
}
}
$Path = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize"
Set-ItemProperty -Path $Path -Name AppsUseLightTheme -Value $DarkMoveValue
Set-ItemProperty -Path $Path -Name SystemUsesLightTheme -Value $DarkMoveValue
}
Catch [System.Security.SecurityException] {
Write-Warning "Unable to set $Path\$Name to $Value due to a Security Exception"
}
Catch [System.Management.Automation.ItemNotFoundException] {
Write-Warning $psitem.Exception.ErrorRecord
}
Catch{
Write-Warning "Unable to set $Name due to unhandled exception"
Write-Warning $psitem.Exception.StackTrace
}
}
function Invoke-DisableAutoDrivers {
Param(
$Enabled,
[string]$Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching",
[string]$name = "SearchOrderConfig"
)
Try{
if ($Enabled -eq $false){
$value = 1
Add-Log -Message "Enabled auto drivers update" -Level "info"
}
else {
$value = 0
Add-Log -Message "Disabled auto drivers update" -Level "info"
}
Set-ItemProperty -Path $Path -Name $name -Value $value -ErrorAction Stop
}
Catch [System.Security.SecurityException] {
Write-Warning "Unable to set $Path\$Name to $Value due to a Security Exception"
}
Catch [System.Management.Automation.ItemNotFoundException] {
Write-Warning $psitem.Exception.ErrorRecord
}
Catch{
Write-Warning "Unable to set $Name due to unhandled exception"
Write-Warning $psitem.Exception.StackTrace
}
}
function Invoke-EnableAutoTray {
Param(
$Enabled,
[string]$Path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer",
[string]$name = "EnableAutoTray"
)
Try{
if ($Enabled -eq $false){
Add-Log -Message "Enabling all tray icons..." -Level "info"
Set-ItemProperty -Path $Path -Name $name -Value 0 -ErrorAction Stop
}
else {
Add-Log -Message "Disabling auto tray icons..." -Level "info"
Remove-ItemProperty -Path $Path -Name $name -ErrorAction Stop
}
Refresh-Explorer
}
Catch [System.Security.SecurityException] {
Write-Warning "Unable to set $Path\$Name to $Value due to a Security Exception"
}
Catch [System.Management.Automation.ItemNotFoundException] {
Write-Warning $psitem.Exception.ErrorRecord
}
Catch{
Write-Warning "Unable to set $Name due to unhandled exception"
Write-Warning $psitem.Exception.StackTrace
}
}
function Invoke-HyperV {
Param($Enabled)
Try{
if ($Enabled -eq $false){
Add-Log -Message "Enabling HyperV..." -Level "info"
Start-Process powershell -ArgumentList 'dism.exe /online /disable-feature /featurename:"Microsoft-Hyper-V-All" /norestart' -Verb RunAs
Add-Log -Message "Restart required" -Level "info"
}
else {
Add-Log -Message "Disabling HyperV..." -Level "info"
Start-Process powershell -ArgumentList 'dism.exe /online /enable-feature /featurename:"Microsoft-Hyper-V-All" /all /norestart' -Verb RunAs
Add-Log -Message "Restart required" -Level "info"
}
}
Catch [System.Security.SecurityException] {
Write-Warning "Unable to set HyperV due to a Security Exception"
}
}
function Invoke-MouseAcceleration {
param (
$Mouse,
$Speed = 0,
$Threshold1  = 0,
$Threshold2  = 0,
[string]$Path = "HKCU:\Control Panel\Mouse"
)
try {
if($Mouse -eq $false)
{
Add-Log -Message "Mouse Acceleration" -Level "info"
$Speed = 1
$Threshold1 = 6
$Threshold2 = 10
}else {
$Speed = 0
$Threshold1 = 0
$Threshold2 = 0
Add-Log -Message "Mouse Acceleration" -Level "info"
}
Set-ItemProperty -Path $Path -Name MouseSpeed -Value $Speed
Set-ItemProperty -Path $Path -Name MouseThreshold1 -Value $Threshold1
Set-ItemProperty -Path $Path -Name MouseThreshold2 -Value $Threshold2
}
catch {
Add-Log -Message "Unable  set valuse" -LEVEL "ERROR"
}
}
function Invoke-NumLock {
param(
[Parameter(Mandatory = $true)]
[bool]$Enabled
)
try {
if ($Enabled -eq $false)
{
Add-Log -Message "Numlock Enabled" -Level "info"
$value = 2
}
else
{
Add-Log -Message "Numlock Disabled" -Level "info"
$value = 0
}
New-PSDrive -PSProvider Registry -Name HKU -Root HKEY_USERS -ErrorAction Stop
$Path = "HKU:\.Default\Control Panel\Keyboard"
$Path2 = "HKCU:\Control Panel\Keyboard"
Set-ItemProperty -Path $Path -Name InitialKeyboardIndicators -Value $value -ErrorAction Stop
Set-ItemProperty -Path $Path2 -Name InitialKeyboardIndicators -Value $value -ErrorAction Stop
}
catch {
Write-Warning "An error occurred: $($_.Exception.Message)"
}
}
function Invoke-PerformanceOptions {
Param(
$Enabled,
[string]$Path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects",
[string]$name = "VisualFXSetting"
)
Try{
if ($Enabled -eq $false){
$value = 2
Add-Log -Message "Enabled auto end tasks" -Level "info"
}
else {
$value = 0
Add-Log -Message "Disabled auto end tasks" -Level "info"
}
Set-ItemProperty -Path $Path -Name $name -Value $value -ErrorAction Stop
Refresh-Explorer
}
Catch [System.Security.SecurityException] {
Write-Warning "Unable to set $Path\$Name to $Value due to a Security Exception"
}
Catch [System.Management.Automation.ItemNotFoundException] {
Write-Warning $psitem.Exception.ErrorRecord
}
Catch{
Write-Warning "Unable to set $Name due to unhandled exception"
Write-Warning $psitem.Exception.StackTrace
}
}
function Invoke-ShowFile {
Param($Enabled)
Try {
if ($Enabled -eq $false)
{
$value = 1
Add-Log -Message "Show hidden files , folders etc.." -Level "info"
}
else
{
$value = 2
Add-Log -Message "Don't Show hidden files , folders etc.." -Level "info"
}
$hiddenItemsKey = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
Set-ItemProperty -Path $hiddenItemsKey -Name Hidden -Value $value
Set-ItemProperty -Path $hiddenItemsKey -Name ShowSuperHidden -Value $value
Refresh-Explorer
}
Catch [System.Security.SecurityException] {
Write-Warning "Unable to set registry keys due to a Security Exception"
}
Catch [System.Management.Automation.ItemNotFoundException] {
Write-Warning $psitem.Exception.ErrorRecord
}
Catch {
Write-Warning "Unable to set registry keys due to unhandled exception"
Write-Warning $psitem.Exception.StackTrace
}
}
function Invoke-ShowFile-Extensions {
Param($Enabled)
Try{
if ($Enabled -eq $false){
$value = 0
Add-Log -Message "Hidden extensions" -Level "info"
}
else {
$value = 1
Add-Log -Message "Hidden extensions" -Level "info"
}
$Path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
Set-ItemProperty -Path $Path -Name HideFileExt -Value $value
Refresh-Explorer
}
Catch [System.Security.SecurityException] {
Write-Warning "Unable to set $Path\$Name to $Value due to a Security Exception"
}
Catch [System.Management.Automation.ItemNotFoundException] {
Write-Warning $psitem.Exception.ErrorRecord
}
Catch{
Write-Warning "Unable to set $Name due to unhandled exception"
Write-Warning $psitem.Exception.StackTrace
}
}
function Invoke-ShowFile-Icons {
param ($Enabled, $Name = "IconsOnly", $Path = "HKCU:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Advanced")
Try {
if ($Enabled -eq $false) {
$value = 1
Add-Log -Message "ON" -Level "info"
}
else {
$value = 0
Add-Log -Message "OFF" -Level "info"
}
Set-ItemProperty -Path $Path -Name $Name -Value $value -ErrorAction Stop
Refresh-Explorer
}
Catch [System.Security.SecurityException] {
Write-Warning "Unable to set $Path\$Name to $Value due to a Security Exception"
}
Catch [System.Management.Automation.ItemNotFoundException] {
Write-Warning $psitem.Exception.ErrorRecord
}
Catch {
Write-Warning "Unable to set $Name due to unhandled exception"
Write-Warning $psitem.Exception.StackTrace
}
}
function Invoke-TaskbarEnd {
Param($Enabled)
Try{
if ($Enabled -eq $false){
$value = 1
Add-Log -Message "Show End Task on taskbar" -Level "info"
}
else {
$value = 0
Add-Log -Message "Disable End Task on taskbar" -Level "info"
}
$Path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\TaskbarDeveloperSettings\"
$name = "TaskbarEndTask"
if (-not (Test-Path $path)) {
New-Item -Path $path -Force | Out-Null
New-ItemProperty -Path $path -Name $name -PropertyType DWord -Value $value -Force | Out-Null
}else {
Set-ItemProperty -Path $Path -Name $name -Value $value -ErrorAction Stop
Refresh-Explorer
Add-Log -Message "This Setting require a restart" -Level "INFO"
}
}
Catch [System.Security.SecurityException] {
Write-Warning "Unable to set $Path\$Name to $Value due to a Security Exception"
}
Catch [System.Management.Automation.ItemNotFoundException] {
Write-Warning $psitem.Exception.ErrorRecord
}
Catch{
Write-Warning "Unable to set $Name due to unhandled exception"
Write-Warning $psitem.Exception.StackTrace
}
}
function Invoke-StickyKeys {
Param($Enabled)
Try {
if ($Enabled -eq $false){
$value = 510
$value2 = 510
Add-Log -Message "Sticky Keys" -Level "info"
}
else {
$value = 58
$value2 = 122
Add-Log -Message "Sticky Keys" -Level "info"
}
$Path = "HKCU:\Control Panel\Accessibility\StickyKeys"
$Path2 = "HKCU:\Control Panel\Accessibility\Keyboard Response"
Set-ItemProperty -Path $Path -Name Flags -Value $value
Set-ItemProperty -Path $Path2 -Name Flags -Value $value2
Refresh-Explorer
Add-Log -Message "This Setting require a restart" -Level "INFO"
}
Catch [System.Security.SecurityException] {
Write-Warning "Unable to set $Path\$Name to $Value due to a Security Exception"
}
Catch{
Write-Warning "Unable to set $Name due to unhandled exception"
}
}
function Invoke-WindowsSandbox {
Param($Enabled)
Try{
if ($Enabled -eq $false){
Add-Log -Message "Enabling Windows Sandbox..." -Level "info"
Start-Process powershell -ArgumentList 'Dism /online /Enable-Feature /FeatureName:"Containers-DisposableClientVM" -All /NoRestart' -Verb RunAs
Add-Log -Message "Restart required" -Level "info"
}
else {
Add-Log -Message "Disabling Windows Sandbox..." -Level "info"
Start-Process powershell -ArgumentList 'Dism /online /Disable-Feature /FeatureName:"Containers-DisposableClientVM"  /NoRestart' -Verb RunAs
Add-Log -Message "Restart required" -Level "info"
}
}
Catch [System.Security.SecurityException] {
Write-Warning "Unable to set Windows Sandbox due to a Security Exception"
}
}
function Invoke-WSL {
Param($Enabled)
Try{
if ($Enabled -eq $false){
Add-Log -Message "Enabling WSL2..." -Level "info"
Start-Process powershell -ArgumentList 'dism.exe /online /enable-feature /featurename:"Microsoft-Windows-Subsystem-Linux" /all /norestart' -Verb RunAs
Start-Process powershell -ArgumentList 'dism.exe /online /enable-feature /featurename:"VirtualMachinePlatform" /all /norestart' -Verb RunAs
Read-Host "Press ENTER to exit..."
Add-Log -Message "Restart required" -Level "info"
}
else {
Add-Log -Message "Disabling WSL2..." -Level "info"
Start-Process powershell -ArgumentList 'dism.exe /online /disable-feature /featurename:"Microsoft-Windows-Subsystem-Linux" /norestart' -Verb RunAs
Start-Process powershell -ArgumentList 'dism.exe /online /disable-feature /featurename:"VirtualMachinePlatform" /norestart' -Verb RunAs
Read-Host "Press ENTER to exit..."
Add-Log -Message "Restart required" -Level "info"
}
}
Catch [System.Security.SecurityException] {
Write-Warning "Unable to set WSL2 due to a Security Exception"
}
}
function About {
$aboutPopup = $itt['window'].FindName('AboutPopup')
$aboutPopup.FindName('ver').Text = "Latest build $($itt.lastupdate)"
$aboutPopup.IsOpen = $true
}
function ITTShortcut {
$appDataPath = "$env:ProgramData/itt"
$localIconPath = Join-Path -Path $appDataPath -ChildPath "icon.ico"
Invoke-WebRequest -Uri $itt.icon -OutFile $localIconPath
$Shortcut = (New-Object -ComObject WScript.Shell).CreateShortcut("$([Environment]::GetFolderPath('Desktop'))\ITT Emad Adel.lnk")
$Shortcut.TargetPath = "$env:SystemRoot\System32\WindowsPowerShell\v1.0\powershell.exe"
$Shortcut.Arguments = "-ExecutionPolicy Bypass -NoProfile -Command ""irm raw.githubusercontent.com/emadadel4/ITT/main/itt.ps1 | iex"""
$Shortcut.IconLocation = "$localIconPath"
$Shortcut.Save()
}
function Find-Driver {
$gpuInfo = Get-CimInstance Win32_VideoController | Where-Object { $_.Status -eq "OK" } | Select-Object -First 1 -ExpandProperty Name
$encodedName = [System.Web.HttpUtility]::UrlEncode($gpuInfo) -replace '\+', '%20'
if (-not $gpuInfo) {
Write-Host "No GPU detected"
}
if ($gpuInfo -match "NVIDIA") {
Start-Process "https://www.nvidia.com/en-us/drivers/"
}
elseif ($gpuInfo -match "AMD" -or $gpuInfo -match "Radeon") {
Start-Process "https://www.amd.com/en/support/download/drivers.html"
}
elseif ($gpuInfo -match "Intel") {
Start-Process "https://www.intel.com/content/www/us/en/search.html?ws=idsa-suggested#q=$encodedName&sort=relevancy&f:@tabfilter=[Downloads]"
}
}
function Search {
$filter = $itt.searchInput.Text.ToLower() -replace '[^\p{L}\p{N}]', ''
$collectionView = [System.Windows.Data.CollectionViewSource]::GetDefaultView($itt['window'].FindName($itt.currentList).Items)
$collectionView.Filter = {
param ($item)
return $item.Content -match $filter -or $item.category -match $filter
}
}
function FilterByCat {
param ($Cat)
$collectionView = [System.Windows.Data.CollectionViewSource]::GetDefaultView($itt['window'].FindName($itt.CurrentList).Items)
if ($Cat -eq "All" -or [string]::IsNullOrWhiteSpace($Cat)) {
$collectionView.Filter = $null
}
else {
$collectionView.Filter = {
param ($item)
$tags = $item.category
return $tags -ieq $Cat
}
}
$collectionView.Refresh()
}
$KeyEvents = {
if ($itt.ProcessRunning) {
Set-Statusbar -Text "📢 Shortcut is disabled while process is running"
return
}
$modifiers = $_.KeyboardDevice.Modifiers
$key = $_.Key
switch ($key) {
"Enter" {
if ($itt.currentList -eq "AppsListView") { Invoke-Install }
elseif ($itt.currentList -eq "TweaksListView") { Invoke-Apply }
}
"S" {
if ($modifiers -eq "Ctrl") {
if ($itt.currentList -eq "AppsListView") { Invoke-Install }
elseif ($itt.currentList -eq "TweaksListView") { Invoke-Apply }
}
elseif ($modifiers -eq "Shift") { Save-File }
}
"D" { if ($modifiers -eq "Shift") { Get-file } }
"Q" {
if ($modifiers -eq "Ctrl") {
$itt.TabControl.SelectedItem = $itt.TabControl.Items | Where-Object { $_.Name -eq "apps" }
}
elseif ($modifiers -eq "Shift") { RestorePoint }
}
"W" { if ($modifiers -eq "Ctrl") { $itt.TabControl.SelectedItem = $itt.TabControl.Items | Where-Object { $_.Name -eq "tweeksTab" } } }
"E" { if ($modifiers -eq "Ctrl") { $itt.TabControl.SelectedItem = $itt.TabControl.Items | Where-Object { $_.Name -eq "SettingsTab" } } }
"I" {
if ($modifiers -eq "Ctrl") { About }
elseif ($modifiers -eq "Shift") { ITTShortcut }
}
"C" { if ($modifiers -eq "Shift") { Start-Process explorer.exe $env:ProgramData\chocolatey\lib } }
"T" { if ($modifiers -eq "Shift") { Start-Process explorer.exe $env:ProgramData\itt } }
"G" { if ($modifiers -eq "Ctrl") { $this.Close() } }
"F" {
if ($modifiers -eq "Ctrl") {
if ($itt.SearchInput.IsFocused) {
$itt.SearchInput.MoveFocus((New-Object System.Windows.Input.TraversalRequest([System.Windows.Input.FocusNavigationDirection]::Next)))
} else {
$itt.SearchInput.Focus()
}
}
}
"A" {
if ($modifiers -eq "Ctrl" -and ($itt.CurrentCategory -eq "AppsCategory" -or $itt.CurrentCategory -eq "TwaeksCategory")) {
$itt["window"].FindName($itt.CurrentCategory).SelectedIndex = 0
}
}
}
}
function Message {
param([string]$key,[string]$NoneKey,[string]$title = "ITT",[string]$icon,[string]$action)
$iconMap = @{ info = "Information"; ask = "Question"; warning = "Warning"; default = "Question" }
$actionMap = @{ YesNo = "YesNo"; OK = "OK"; default = "OK" }
$icon = if ($iconMap.ContainsKey($icon.ToLower())) { $iconMap[$icon.ToLower()] } else { $iconMap.default }
$action = if ($actionMap.ContainsKey($action.ToLower())) { $actionMap[$action.ToLower()] } else { $actionMap.default }
$msg = if ([string]::IsNullOrWhiteSpace($key)) { $NoneKey } else { $itt.database.locales.Controls.$($itt.Language).$key }
[System.Windows.MessageBox]::Show($msg, $title, [System.Windows.MessageBoxButton]::$action, [System.Windows.MessageBoxImage]::$icon)
}
function Notify {
param(
[string]$title,
[string]$msg,
[string]$icon,
[Int32]$time
)
$notification = New-Object System.Windows.Forms.NotifyIcon
$notification.Icon = [System.Drawing.SystemIcons]::Information
$notification.BalloonTipIcon = $icon
$notification.BalloonTipText = $msg
$notification.BalloonTipTitle = $title
$notification.Visible = $true
$notification.ShowBalloonTip($time)
$notification.Dispose()
}
function System-Default {
try {
$dc = $itt.database.locales.Controls.$shortCulture
if (-not $dc -or [string]::IsNullOrWhiteSpace($dc)) {
Set-Statusbar -Text "Your default system language is not supported yet, fallback to English"
$dc = $itt.database.locales.Controls.en
}
$itt["window"].DataContext = $dc
Set-ItemProperty -Path $itt.registryPath -Name "locales" -Value "default" -Force
}
catch {
Write-Host "An error occurred: $_"
}
}
function Set-Language {
param ([string]$lang)
if ($lang -eq "default") { System-Default }
else {
$itt.Language = $lang
$itt["window"].DataContext = $itt.database.locales.Controls.$($itt.Language)
Set-ItemProperty -Path $itt.registryPath -Name "locales" -Value $lang -Force
}
}
function SwitchToSystem {
try {
$appsTheme = Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme"
$theme = if ($AppsTheme -eq "0") { "Dark" } elseif ($AppsTheme -eq "1") { "Light" } else { Write-Host "Unknown theme: $AppsTheme"; return }
$itt['window'].Resources.MergedDictionaries.Add($itt['window'].FindResource($theme))
Set-ItemProperty -Path $itt.registryPath -Name "Theme" -Value "default" -Force
$itt.Theme = $Theme
}
catch { Write-Host "Error: $_" }
}
function Set-Theme {
param ([string]$Theme)
try {
$itt['window'].Resources.MergedDictionaries.Clear()
$itt['window'].Resources.MergedDictionaries.Add($itt['window'].FindResource($Theme))
Set-ItemProperty -Path $itt.registryPath -Name "Theme" -Value $Theme -Force
$itt.Theme = $Theme
}
catch { Write-Host "Error: $_" }
}
function Set-Statusbar {
param ([string]$Text)
$itt.Statusbar.Dispatcher.Invoke([Action]{$itt.Statusbar.Text = $Text })
}
function UpdateUI {
param([string]$Button,[string]$Content,[string]$NonKey,[string]$Width = "140")
$itt['window'].Dispatcher.Invoke([Action]{
$itt.$Button.Width = $Width
if($Content)
{
$itt.$Button.Content = $itt.database.locales.Controls.$($itt.Language).$Content
}else{
$itt.$Button.Content = $NonKey
}
})
}
