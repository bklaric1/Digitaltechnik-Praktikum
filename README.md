Praktikum Digitaltechnik
========================

Im Rahmen des Praktikums Digitaltechnik werden kombinatorische und sequentielle Schaltungen mit dem Modelsim Simulator simuliert und mit der Intel Quartus Software für eine Altera FPGA synthetisiert. Die Schaltungen können auf dem Altera DE1 Board ausprobiert und untersucht werden. 

  * Boolesche Ausdrücke
  * Binaer zu 7Segment Konverter
  * Addierer
  * Zaehler
  * Automate
  
Technische Umsetzung
--------------------

### Entwicklungsumgebung

Die Schaltungsteile sind in VHDL beschrieben. Als FPGA Board
wird das Altera DE1 Board verwendet. Die Designsoftware ist kostenlos von Altera erhaeltlich. 

  * Synthese: Altera Quartus II
  * Simulation: Altera Mentor Modelsim (Web Edition)

Die Designsoftware ist auf einer virtuellen Maschine fertig installiert. Eine Beschreibung ist hier: http://www.hs-augsburg.de/~beckmanf/dokuwiki/doku.php?id=ubuntu_virtual_cae_system

### Ordnerstruktur

src: hier sind alle VHDL Quelldateien
sim: hier sind die Makefiles fuer die Simulation der Komponenten
pnr: Place and Route - Die makefiles fuer die Synthese der Schaltung
scripts: Globale scripts

### Download, Simulation und Synthese 

Das Projekt ist unter git Versionsverwaltung. Zum Download sind die folgenden Schritte notwendig: 

```
mkdir projects
cd projects
git clone https://gitlab.elektrotechnik.hs-augsburg.de/beckmanf/digitaltechnikpraktikum.git
cd digitaltechnikpraktikum
```

Hier die Simulation von geschalteten LEDs:

```
cd sim
cd ledsw
make sim
```

Die zugehörige Synthese:

```
cd ../../pnr
cd ledsw-make
make quartus
```

Um das Design auf das Board zu laden muss das Board mit dem Kabel an den USB Anschluss des Rechners angeschlossen sein. Dann:

```
make prog
```

Ein einfaches make zeigt die moeglichen Targets. 

