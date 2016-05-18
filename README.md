# DrillSimFPC

DrillSim (1988) re-written for the 21st Century
Ambersoft (Langworth UK)
DrillSim 3.0.0

##Components


* Compiler
  - Lazarus 1.2.6
  - FPC 2.6.4

* Compiler Options
  - Other unit file -Fu => /usr/lib/fpc/2.6.4/units/x86_64-linux/
  - Include files -Fi => $(ProjOutDir)
  - Libraries -FI => <empty>
  - Unit output directory -FU => lib/$(TargetCPU)-$(TargetOS)
  - Target name -o => DrillSim3
  - Target OS -T => Linux
  - Target CPU family -P => x86-64
  - Target processor => (Default)

* From the command line using FPC:
  ```
  $ fpc -vut -B  -MObjFPC -Scghi -O1 -Tlinux -Px86_64 -g -gl -vewnhi -Filib/x86_64-linux -Fl/opt/gnome/lib -Fu/usr/lib/fpc/2.6.4/units/x86_64-linux -Fu/usr/share/lazarus/1.2.6/lcl/units/x86_64-linux/gtk2 -Fu/usr/share/lazarus/1.2.6/lcl/units/x86_64-linux -Fu/usr/share/lazarus/1.2.6/components/lazutils/lib/x86_64-linux -Fu/usr/share/lazarus/1.2.6/packager/units/x86_64-linux -Fu. -FUlib/x86_64-linux -l -dLCL -dLCLgtk2 DrillSim3.lpr
  ```
  
* compile.sh
  ```
  fpc -vut -B @extrafpc.cfg DrillSim3.lpr
  ```
* extrafpc.cfg

  ```
  #-FUunits
  #-Fu./units
  -Fu../../../lib/$fpctarget
  -Fu/usr/share/lazarus/1.2.6/lcl/units/x86_64-linux/gtk2
  -Fu/usr/share/lazarus/1.2.6/lcl/units/x86_64-linux
  -Fu/usr/share/lazarus/1.2.6/components/lazutils/lib/x86_64-linux
  #-Fu/Software/FPC_G/lib/x86_64-linux
  -Xs
  -XX
  -CX
  #ifdef mswindows
  -WG
  #endif
  ```
* Additional Units:

  - splash – splash/help screen - extract in code directory
  - synapse40 – networking library - extract in code directory

* Additional sub-directories:

  - backup – created by Lazarus
  - lib – created by Lazarus
  - images – location of Kelly etc image files


