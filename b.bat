@echo on
"C:\Program Files\WinRAR\Rar.exe" a -rr -m5 -r -ag[dd-mm-yyyy_hh.mm.ss] -x*.rar -x*.dcu -x*.~* -x*.txt -x*.his -x*.zip -x\log -x\.git sem2reader.rar *.* 
@pause

