--#class "test"
--#description "Windows test for loadlib."
-- Quick and dirty test of the loadlib functionality. Note that
-- the functions exported by the LabVIEW executable are
-- mostly not public and thus cannot be assumed to remain
-- supported. Oonly works under Windows.

beep = loadlib(lv.app_path().._SEP.."LabVIEW.exe","WBeep")
beep()
